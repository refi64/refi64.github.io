import 'package:vue/vue.dart';

import 'dart:async';

import 'common.dart';
import 'post_teaser.dart';


@VueComponent(template: '<<', components: [PostTeaser])
class PostList extends VueComponentBase {
  PostList(): super();

  @override
  void lifecycleMounted() => load();

  Future load() async {
    posts = await getPosts();
    return new Future.value();
  }

  @data
  List posts = [];

  @computed
  bool get hasPosts => !posts.isEmpty;
}
