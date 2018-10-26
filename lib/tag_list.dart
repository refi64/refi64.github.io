import 'package:vue/vue.dart';
import 'package:vdmc/vdmc.dart';

import 'common.dart';
import 'post_teaser.dart';
import 'site_tags.dart';

import 'dart:async';
import 'dart:html';


@VueComponent(template: '<<', components: [PostTeaser, SiteTags, MTypoHeadline, MChip])
class TagList extends VueComponentBase {
  TagList(): super();

  @override
  void lifecycleMounted() {
    hashchange();
    window.onHashChange.listen((evt) => hashchange());
    load();
  }

  Future load() async {
    posts = await getPosts();
    return Future.value();
  }

  @prop
  bool tagPage = false;

  @data
  bool doneLoading = false;
  @data
  String tag = '';
  @data
  List posts = [];
  @data
  List allTags = [];
  @data
  List ourPosts = [];

  @computed
  bool get istag => tag.isNotEmpty && tagPage;
  @computed
  String get allTagsString => allTags.join(', ');

  @watch('posts')
  void watchPosts() => updateTags();
  @watch('tag')
  void watchTag() => updateTags();

  Future updateTags() async {
    doneLoading = false;

    for (var postName in posts) {
      var post = await getPost('/posts/$postName.html');

      var tagElement = post.querySelector('site-tags');
      var tagAttrs = tagElement?.attributes ?? {};
      var tags = tagAttrs['tags']?.split(',')?.map((tag) => tag.trim());

      if (tags == null) {
        window.console.error('$postName has no tags');
        continue;
      }

      if (istag) {
        if (tags.contains(tag)) {
          ourPosts.add(postName);
        }
      } else {
        allTags.addAll(tags.where((tag) => !allTags.contains(tag)));
      }
    }

    allTags.sort();
    doneLoading = true;
  }

  void hashchange() {
    var hash = window.location.hash;
    if (hash.isEmpty) {
      tag = '';
    } else {
      tag = Uri.decodeComponent(hash.substring(1));
    }
  }
}
