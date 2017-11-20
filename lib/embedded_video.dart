import 'package:vue2/vue.dart';


@VueComponent(name: 'embedded-video', template: '<<')
class EmbeddedVideo extends VueComponentBase {
  EmbeddedVideo(context): super(context);

  @prop
  String url;
  @prop
  int width;
  @prop
  int height;

  @computed
  String get iframeStyle => 'max-width: $width; max-height: $height;';
}
