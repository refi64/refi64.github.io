import 'package:vue/vue.dart';

import 'package:vdmc/vdmc.dart';

import 'dart:html';


@VueComponent(template: '<<', components: [MChipSet, MChip])
class SiteTags extends VueComponentBase {
  SiteTags(): super();

  @prop
  String tags;

  @computed
  List<String> get tagsList => tags.isNotEmpty
                                ? tags.split(', ').map((tag) => tag.trim()).toList()
                                : <String>[];
}
