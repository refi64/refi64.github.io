import 'package:vue/vue.dart';

import 'dart:html';


@VueComponent(template: '<<')
class SiteTitle extends VueComponentBase {
  SiteTitle(): super();

  @prop
  String createdOn;
  @prop
  String title = document.title;
  @prop
  String url = window.location.pathname;

  @computed
  String get comments => '$url#comments';
}
