import 'package:vue2/vue.dart';

import 'dart:html';


@VueComponent(name: 'embedded-image', template: '<<')
class EmbeddedImage extends VueComponentBase {
  EmbeddedImage(context): super(context);

  @override
  void mounted() {
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
