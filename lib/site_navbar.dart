import 'package:vue/vue.dart';
import 'package:vdmc/vdmc.dart';

import 'package:user_agent/user_agent.dart';

import 'if_mobile.dart';
import 'site_navlist.dart';

import 'dart:html';


@VueComponent(template: '<<', components: [MButton, MTypoHeadline, MTopAppBar,
                                           MTopAppBarFixedAdjust, MIconButton,
                                           MDrawerTemporary, MDrawerToolbarSpacer, MDrawerContent, SiteNavlist, MDrawerPermanent])
class SiteNavbar extends VueComponentBase with IfMobileMixin {
  static final DISMISSED_KEY = 'firefox-android-warning-dismissed';
  final userAgent = UserAgent(window.navigator.userAgent);

  @ref
  MDrawerTemporary nav;

  @data
  bool navOpen = false;
  @data
  bool firefoxAndroidWarningShowing = !window.localStorage.containsKey(DISMISSED_KEY);

  @prop
  String sideTitle = '';

  @computed
  bool get isFirefoxAndroid => userAgent.isFirefox && userAgent.isAndroid;
  @computed
  bool get showFirefoxAndroidWarning => isFirefoxAndroid && firefoxAndroidWarningShowing;

  @method
  void toggleNav() => navOpen = !nav.open;

  @method
  void hideFirefoxAndroidWarning() {
    firefoxAndroidWarningShowing = false;
    window.localStorage[DISMISSED_KEY] = 'dismissed';
  }
}
