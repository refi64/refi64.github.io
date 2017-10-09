import 'package:vue2/vue.dart';

import 'dart:html';


@VueComponent('site-tags', template: '<<')
class SiteTags extends VueComponentBase {
  SiteTags(context): super(context);

  @prop
  String tags;
  @prop
  dynamic noHeader = null;

  @computed
  List<String> get tagsList {
    return tags.split(', ').map((tag) => tag.trim().toUpperCase()).toList();
  }

  @method
  void tagclick(String tag) {
    window.location.href = '/tags.html#${Uri.encodeComponent(tag.toLowerCase())}';
  }
}
