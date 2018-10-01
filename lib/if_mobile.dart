import 'package:vue/vue.dart';

import 'dart:html';


bool isMobile() => document.body.clientWidth <= 480;


@VueComponent(template: '<<')
class IfMobile extends VueComponentBase {
  IfMobile(): super();

  @override
  void lifecycleMounted() {
    window.onResize.listen((Event event) {
      mobile = isMobile();
    });
  }

  @data
  bool mobile = isMobile();
}
