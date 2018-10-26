import 'package:vue/vue.dart';

import 'package:vdmc/vdmc.dart';

import 'dart:html';
import 'if_mobile.dart';


@VueComponent(template: '<<', components: [MTypoHeadline, MTypoSubheading])
class SiteTitle extends VueComponentBase with IfMobileMixin {
  SiteTitle(): super();

  @prop
  String createdOn;
  @prop
  String title = document.title;
  @prop
  String url = window.location.pathname;
  @prop
  bool small = false;

  @computed
  String get comments => '$url#comments';
  @computed
  int get headerLevel => (small ? 4 : 3) + (mobile ? 1 : 0);
}
