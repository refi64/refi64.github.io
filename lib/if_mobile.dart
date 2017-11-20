import 'package:vue2/vue.dart';

import 'dart:html';

import 'if_mobile.dart';


bool isMobile() => document.body.clientWidth <= 480;


@VueComponent(name: 'if-mobile', template: '<<')
class IfMobile extends VueComponentBase {
  IfMobile(context): super(context);

  @override
  void mounted() {
    window.onResize.listen((Event event) {
      mobile = isMobile();
    });
  }

  @data
  bool mobile = isMobile();
}
