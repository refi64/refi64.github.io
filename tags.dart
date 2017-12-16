import 'package:vue2/vue.dart';

import 'package:blockbyte/common.dart';
import 'package:blockbyte/tag_list.dart';

import 'dart:async';


@VueApp(el: '#page')
class Page extends VueAppBase {
  factory Page() => VueAppBase.create((context) => new Page._(context));
  Page._(context): super(context);
@override
VueAppConstructor get constructor => new VueAppConstructor(
  el: '#page',
  data: {},
  computed: {},
  watchers: {},
  methods: {},
    
);
      }


Page page;


Future main() async {
  await init();
  page = new Page();
  return new Future.value();
}
@initMethod
void vuedart_INTERNAL_init() {

}
    