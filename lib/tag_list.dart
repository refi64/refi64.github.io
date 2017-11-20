import 'package:vue2/vue.dart';

import 'common.dart';
import 'post_teaser.dart';
import 'site_tags.dart';

import 'dart:async';
import 'dart:html';


@VueComponent(name: 'tag-list', template: '<<')
class TagList extends VueComponentBase {
  TagList(context): super(context);

  @override
  void mounted() {
    hashchange();
    window.onHashChange.listen((evt) => hashchange());

    getPosts().then((posts) => this.posts = posts);
  }

  @prop
  dynamic tagPage = null;

  @data
  String tag = '';
  @data
  List<String> posts = [];
  @data
  List<String> allTags = [];
  @data
  List<String> ourPosts = [];

  @computed
  bool get istag => tag.isNotEmpty && tagPage != null;
  @computed
  String get allTagsString => allTags.join(', ');
  @computed
  bool get hasPosts => posts.isNotEmpty && (istag ? ourPosts.isNotEmpty : true);

  @watch('posts')
  void watchPosts() => updateTags();
  @watch('tag')
  void watchTag() => updateTags();

  Future updateTags() async {
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
        allTags.sort();
      }
    }
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
