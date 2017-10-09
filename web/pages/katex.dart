import 'package:vue2/vue.dart';

import 'package:blockbyte/common.dart';
import 'package:blockbyte/math_preview.dart';

import 'dart:async';


@VueApp(el: '#page')
class Page extends VueAppBase {
  factory Page() => VueAppBase.create((context) => new Page._(context));
  Page._(context): super(context);
}


Page page;


Future main() async {
  await init();
  page = new Page();
  return new Future.value();
}
