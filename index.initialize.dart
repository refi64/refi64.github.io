import 'package:initialize/src/static_loader.dart';
import 'package:initialize/initialize.dart';
import 'index.dart' as i0;
import 'package:blockbyte/embedded_image.dart' as i1;
import 'package:initialize/initialize.dart' as i2;
import 'package:blockbyte/link_header.dart' as i3;
import 'package:blockbyte/if_mobile.dart' as i4;
import 'package:blockbyte/site_navbar.dart' as i5;
import 'package:blockbyte/site_title.dart' as i6;
import 'package:blockbyte/site_suffix.dart' as i7;
import 'package:blockbyte/site_tags.dart' as i8;
import 'package:blockbyte/post_teaser.dart' as i9;
import 'package:blockbyte/post_list.dart' as i10;

main() {
  initializers.addAll([
    new InitEntry(i2.initMethod, i1.vuedart_INTERNAL_init),
    new InitEntry(i2.initMethod, i3.vuedart_INTERNAL_init),
    new InitEntry(i2.initMethod, i4.vuedart_INTERNAL_init),
    new InitEntry(i2.initMethod, i5.vuedart_INTERNAL_init),
    new InitEntry(i2.initMethod, i6.vuedart_INTERNAL_init),
    new InitEntry(i2.initMethod, i7.vuedart_INTERNAL_init),
    new InitEntry(i2.initMethod, i8.vuedart_INTERNAL_init),
    new InitEntry(i2.initMethod, i9.vuedart_INTERNAL_init),
    new InitEntry(i2.initMethod, i10.vuedart_INTERNAL_init),
    new InitEntry(i2.initMethod, i0.vuedart_INTERNAL_init),
  ]);

  return i0.main();
}
