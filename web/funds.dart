import 'package:vue/vue.dart';
import 'package:vdmc/vdmc.dart';

import 'package:blockbyte/common.dart';


@VueApp(el: '#page', components: [MCard, MCardMedia, MLayoutGrid, MLayoutGridInner,
                                  MLayoutGridCell, MTypoHeadline])
class Page extends VueAppBase with CommonElements {
}


Page page;


void main() {
  init();
  page = new Page();
  page.create();
}
