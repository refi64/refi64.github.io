import 'package:vue/vue.dart';
import 'package:vdmc/vdmc.dart';

import 'dart:async';

import 'common.dart';
import 'loading_circle.dart';
import 'post_teaser.dart';


@VueComponent(template: '<<', components: [PostTeaser, LoadingCircle])
class PostList extends VueComponentBase {
  PostList(): super();

  @override
  void lifecycleMounted() => load();

  Future load() async {
    posts = await getPosts();
    checkLoaded();
    return new Future.value();
  }

  @data
  List posts = [];
  @data
  List loadedPosts = [];
  @data
  bool doneLoading = false;

  @computed
  bool get hasPosts => !posts.isEmpty;

  @method
  void postLoaded(String post) {
    loadedPosts.add(post);
    checkLoaded();
  }

  void checkLoaded() {
    if (posts.isNotEmpty && posts.length == loadedPosts.length) {
      // XXX: no clue why this is needed
      doneLoading = true;
      doneLoading = false;
      Future.delayed(const Duration(milliseconds: 1), () {
        doneLoading = true;
      });
    }
  }
}
