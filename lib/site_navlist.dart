import 'package:vue/vue.dart';
import 'package:vdmc/vdmc.dart';

import 'if_mobile.dart';


@VueComponent(template: '<<', components: [MTypoHeadline, MList, MListGroupSubheader,
                                           MListGroupDivider, MListItem])
class SiteNavlist extends VueComponentBase with IfMobileMixin {
  @data
  dynamic headers = mapToJs({
    'root': [
      ['Home', 'home', '/'],
      ['RSS', 'rss_feed', 'https://feed43.com/4061761183385368.xml'],
      ['Tags', 'label', '/tags.html'],
      ['Report a bug', 'bug_report', 'https://github.com/kirbyfan64.github.io/issues'],
    ],

    'menus': [
      ['Projects', 'code'],
      ['Misc', 'settings'],
      ['Links', 'link'],
    ],

    'Projects': [
      ['XCXSound', '/proj/xcxsound.html'],
      ['zdata', '/proj/zdata.html'],
      ['VueDart', '/vuedart/'],
    ],

    'Misc': [
      ['APT repository', '/pages/apt.html'],
      ['KaTeX previewer', '/pages/katex.html'],
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
