import 'package:vue2/vue.dart';

import 'dart:async';

import 'common.dart';
import 'post_teaser.dart';


@VueComponent(name: 'post-list', template: '<<')
class PostList extends VueComponentBase {
  PostList(context): super(context);

  void mounted() => load();

  Future load() async {
    posts = await getPosts();
    return new Future.value();
  }

  @data
  List<String> posts = [];

  @computed
  bool get hasPosts => !posts.isEmpty;
}
