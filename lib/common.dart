@JS()
library blockbyte.common;

// import 'package:aspen_assets/aspen_assets.dart' as aspen;
import 'package:vue/vue.dart';

import 'package:vdmc/vdmc.dart';

import 'package:blockbyte/embedded_image.dart';
import 'package:blockbyte/link_header.dart';
import 'package:blockbyte/site_navbar.dart';
import 'package:blockbyte/site_title.dart';
import 'package:blockbyte/site_suffix.dart';

import 'package:js/js.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:html';


Future<List<String>> getPosts() async {
  var str = await HttpRequest.getString('/posts.json');
  return new Future.value(List<String>.from(json.decode(str)['posts']));
}


Future<Document> getPost(String url) async {
  var str = await HttpRequest.getString(url);
  return new DomParser().parseFromString(str, 'text/html');
}


void appendScript(String src) {
  var script = new ScriptElement();
  script.src = src;
  document.head.append(script);
}


void appendStyle(String href) {
  var style = new LinkElement();
  style.rel = 'stylesheet';
  style.href = href;
  document.head.append(style);
}


ScriptElement muutjs;


void init() {
  VueConfig.ignoredElements = ['share-button'];
}

@VueMixin(components: [EmbeddedImage, LinkHeader, SiteNavbar, SiteTitle, SiteSuffix, MTypography])
abstract class CommonElements implements VueMixinRequirements {}
