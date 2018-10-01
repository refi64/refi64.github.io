import 'package:vue/vue.dart';

import 'package:blockbyte/common.dart';
import 'package:blockbyte/tag_list.dart';


@VueApp(el: '#page', components: [TagList])
class Page extends VueAppBase with CommonElements {}


Page page;


void main() {
  init();
  page = new Page();
  page.create();
}
