import 'package:vue2/vue.dart';

import 'dart:html';


@VueComponent(name: 'site-title', template: '<<')
class SiteTitle extends VueComponentBase {
  SiteTitle(context): super(context);

  @prop
  String createdOn;
  @prop
  String title = document.title;
  @prop
  String url = window.location.pathname;

  @computed
  String get comments => '$url#comments';
}
