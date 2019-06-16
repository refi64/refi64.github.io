import 'package:vue/vue.dart';

import 'package:blockbyte/common.dart';
import 'package:blockbyte/embedded_video.dart';
import 'package:blockbyte/site_tags.dart';


@VueApp(el: '#page', components: [EmbeddedVideo, SiteTags])
class Page extends VueAppBase with CommonElements {
}


Page page;


void main() async {
  await init();
  page = new Page();
  page.create();
}
