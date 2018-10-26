import 'package:vue/vue.dart';

import 'package:vdmc/vdmc.dart';

import 'if_mobile.dart';


@VueComponent(template: '<<', components: [MIcon, MIconButton, MTypoHeadline])
class LinkHeader extends VueComponentBase {
  LinkHeader(): super();

  @prop
  String id;
  @prop
  bool small = false;

  @computed
  String get ref => '#$id';
}
