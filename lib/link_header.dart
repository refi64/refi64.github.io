import 'package:vue/vue.dart';


@VueComponent(template: '<<')
class LinkHeader extends VueComponentBase {
  LinkHeader(): super();

  @prop
  String id;
  @prop
  dynamic small = null;

  @computed
  String get ref => '#$id';
}
