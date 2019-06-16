import 'package:vue/vue.dart';

import 'package:blockbyte/common.dart';
import 'package:blockbyte/post_list.dart';


@VueApp(el: '#page', components: [PostList])
class Page extends VueAppBase with CommonElements {
}


Page page;


void main() async {
  await init();
  page = new Page();
  page.create();
}
