import 'package:vue2/vue.dart';


@VueComponent('link-header', template: '<<')
class LinkHeader extends VueComponentBase {
  LinkHeader(context): super(context);

  @prop
  String id;
  @prop
  dynamic small = null;

  @computed
  String get ref => '#$id';
}
