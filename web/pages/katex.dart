import 'package:vue/vue.dart';

import 'package:blockbyte/common.dart';
import 'package:blockbyte/math_preview.dart';


@VueApp(el: '#page', components: [MathPreview])
class Page extends VueAppBase with CommonElements {
}


Page page;


void main() {
  init();
  page = new Page();
  page.create();
}
