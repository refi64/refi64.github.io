import 'package:vue/vue.dart';

import 'dart:html';


bool isMobile() => window.innerWidth <= 480;


@VueMixin()
abstract class IfMobileMixin implements VueMixinRequirements {
  @override
  void lifecycleMounted() {
    window.onResize.listen((Event event) {
      mobile = isMobile();
    });
  }

  @data
  bool mobile = isMobile();
}
