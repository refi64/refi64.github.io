import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:html/parser.dart' show parse;
import 'package:html_unescape/html_unescape.dart';
import 'package:protic/protic.dart';
import 'package:source_span/source_span.dart' show SourceFile;
import 'package:source_maps/refactor.dart';


class BuildProvider extends FileProvider {
  String base;
  BuildProvider(this.base);

  String read(String path) {
    if (path.endsWith('base.html')) {
      return base;
    } else {
      return null;
    }
  }
}


class ProticBuilder implements Builder {
  @override final buildExtensions = const {
    '.p.html': const ['.html']
  };

  @override
  Future build(BuildStep buildStep) async {
    var inputId = buildStep.inputId;
    var input = await buildStep.readAsString(inputId);

    var base = await buildStep.readAsString(new AssetId(inputId.package,
                                                        'web/base.html'));
    var result = compile(input, fileProvider: new BuildProvider(base));

    for (var error in result.errors) {
      log.severe(error.toString());
    }

    var contents = result.code;
    var doc = parse(contents, generateSpans: true);
    var rewriter = new TextEditTransaction(contents,
                                           new SourceFile.fromString(contents));
    var unescape = new HtmlUnescape();

    var nodes = doc.querySelectorAll('pygments');
    for (var node in nodes) {
      var code = node.innerHtml;
      var lang = 'text';

      if (node.classes.isNotEmpty) {
        lang = node.classes.first;
      }

      if (!node.attributes.containsKey('escape')) {
        code = unescape.convert(code);
      }

      var proc = await Process.start('pygmentize', ['-l', lang, '-f', 'html']);
      proc.stdin.write(code.trim());
      await proc.stdin.flush();
      await proc.stdin.close();
      var formattedCode = await proc.stdout.map(utf8.decode).join();

      rewriter.edit(node.sourceSpan.start.offset, node.endSourceSpan.end.offset,
                    formattedCode.trim());
    }

    var printer = rewriter.commit();
    printer.build(null);

    var outputId = new AssetId(inputId.package,
                               inputId.path.replaceAll('.p.html', '.html'));
    await buildStep.writeAsString(outputId, printer.text);
  }
}

Builder proticBuilder(BuilderOptions options) => new ProticBuilder();
