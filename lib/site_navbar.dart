import 'package:vue2/vue.dart';
import 'package:vue2/plugins/vuematerial.dart';

import 'if_mobile.dart';


@VueComponent(name: 'site-navbar', template: '<<')
class SiteNavbar extends VueComponentBase {
  SiteNavbar(context): super(context);

  @method
  void toggleNav() => sidenav.toggle();

  @ref
  MdSidenav sidenav;

  @data
  dynamic headers = mapToJs({
    'root': [
      ['Home', '/'],
      ['RSS', 'https://feed43.com/4061761183385368.xml'],
      ['Tags', '/tags.html'],
    ],

    'menus': ['Projects', 'Misc', 'Links'],

    'Projects': [
      ['XCXSound', '/proj/xcxsound.html'],
      ['zdata', '/proj/zdata.html'],
      ['VueDart', '/vuedart/'],
      ['Other projects', '/projects.html'],
    ],

    'Misc': [
      ['APT Repository', '/pages/apt.html'],
      ['Katex Previewer', '/pages/katex.html'],
    ],

    'Links': [
      ['GitHub', 'https://github.com/kirbyfan64'],
      ['Twitter', 'https://twitter.com/refi_64'],
      ['GameFAQs', 'http://www.gamefaqs.com/community/kirbyfan64sos'],
      ['Stack Overflow', 'http://stackoverflow.com/users/2097780/refi64'],
      ['Darcs Hub', 'http://hub.darcs.net/refi64'],
      ['SoundCloud', 'https://soundcloud.com/user-356790806'],
      ['XDA Developers', 'https://forum.xda-developers.com/member.php?u=5569318'],
      ['VGMdb', 'http://vgmdb.net/forums/member.php?u=24312'],
    ],
  });
}
