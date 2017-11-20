import 'package:vue2/vue.dart';

import 'dart:async';

import 'common.dart';
import 'site_title.dart';


@VueComponent(name: 'post-teaser', template: '<<')
class PostTeaser extends VueComponentBase {
  PostTeaser(context): super(context);

  void mounted() => load();

  Future load() async {
    var doc = await getPost(url);
    title = doc.querySelector('title').innerHtml;
    createdOn = doc.querySelector('site-title').attributes['created-on'];
    teaser = doc.querySelector('#teaser').innerHtml;

    return new Future.value();
  }

  @prop
  String post;

  @data
  String title = '';
  @data
  String createdOn = '';
  @data
  String teaser = '';

  @computed
  bool get hasPost => teaser.length > 0;
  @computed
  String get url => '/posts/$post.html';
}
