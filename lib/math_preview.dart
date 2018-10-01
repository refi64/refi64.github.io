@JS()
library blockbyte.math_preview;

import 'package:vue/vue.dart';

import 'package:js/js.dart';


@JS('katex.renderToString')
external String _katexRenderToString(String math);


@VueComponent(template: '<<')
class MathPreview extends VueComponentBase {
  MathPreview(): super();

  @data
  String math = '';
  @data
  String error = '';
  @data
  String result = '';

  @computed
  bool get hasError => error.isNotEmpty;

  @watch('math')
  void watchMath() {
    try {
      result = _katexRenderToString(math);
      error = '';
    } catch (err) {
      result = '';
      error = err.toString();
    }
  }
}
