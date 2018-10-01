import 'package:vue/vue.dart';


@VueComponent(template: '<<')
class EmbeddedVideo extends VueComponentBase {
  EmbeddedVideo(): super();

  @prop
  String url;
  @prop
  int width;
  @prop
  int height;

  @computed
  String get iframeStyle => 'max-width: $width; max-height: $height;';
}
