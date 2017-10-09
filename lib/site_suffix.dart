@JS()
library blockbyte.site_suffix;

import 'package:vue2/vue.dart';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

import 'common.dart';
import 'embedded_image.dart';

import 'dart:html';


@JS()
@anonymous
class JqueryElement {
  external void muut(String url);
  external dynamic get fn;
}

@JS()
class ShareButton {
  external ShareButton();
}


@JS()
external dynamic get window;

@JS()
external dynamic get muut;

@JS(r'$')
external JqueryElement jQuery(dynamic el);

@JS('muut.urlify')
external String urlify(String title);

@JS()
external void whenDefined(dynamic obj, String prop, dynamic func);


const MUUT_PREFIX = 'https://muut.com/i/blockbyte/general:';


@VueComponent('site-suffix', template: '<<')
class SiteSuffix extends VueComponentBase {
  SiteSuffix(context): super(context);

  @override
  void mounted() {
    new ShareButton();

    appendStyle('https://cdn.muut.com/1/moot.css');
    appendScript('https://cdn.muut.com/1/moot.min.js');

    whenDefined(window, 'muut', allowInterop(() {
      whenDefined(muut, 'language', allowInterop(() {
        var url = '$MUUT_PREFIX${urlify(document.title)}' +
                  '\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00';
        jQuery(comments).muut(url);
      }));
    }));
  }

  @ref
  dynamic comments;
}
