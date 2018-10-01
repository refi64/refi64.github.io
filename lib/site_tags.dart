import 'package:vue/vue.dart';

import 'dart:html';


@VueComponent(template: '<<')
class SiteTags extends VueComponentBase {
  SiteTags(): super();

  @prop
  String tags;
  @prop
  dynamic noHeader = null;

  @computed
  List<String> get tagsList =>
    tags.split(', ').map((tag) => tag.trim().toUpperCase()).toList();

  @method
  void tagclick(String tag) {
    window.location.href = '/tags.html#${Uri.encodeComponent(tag.toLowerCase())}';
  }
}
