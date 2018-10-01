import 'package:vue/vue.dart';

import 'dart:html';


@VueComponent(template: '<<')
class EmbeddedImage extends VueComponentBase {
  EmbeddedImage(): super();

  @override
  void lifecycleMounted() {
    window.onResize.listen((evt) => imgsize());
  }

  @prop
  String url = '';
  @prop
  String alt = '';
  @prop
  String text = '';

  @data
  String textwidth = null;

  @computed
  bool get hastext => text.isNotEmpty;

  @method
  void imgsize() {
    textwidth = '${image.clientWidth}px';
  }

  @ref
  ImageElement image;
}
