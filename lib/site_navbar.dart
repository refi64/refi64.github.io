import 'package:vue/vue.dart';
import 'package:vdmc/vdmc.dart';

import 'if_mobile.dart';
import 'site_navlist.dart';


@VueComponent(template: '<<', components: [MButton, MTypoHeadline, MTopAppBar,
                                           MTopAppBarFixedAdjust, MIconButton,
                                           MDrawerTemporary, MDrawerToolbarSpacer, MDrawerContent, SiteNavlist, MDrawerPermanent])
class SiteNavbar extends VueComponentBase with IfMobileMixin {
  SiteNavbar(): super();

  @ref
  MDrawerTemporary nav;

  @data
  bool navOpen = false;

  @prop
  String sideTitle = '';

  @method
  void toggleNav() => navOpen = !nav.open;
}
