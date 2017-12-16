@JS()
library blockbyte.common;

import 'package:aspen_assets/aspen_assets.dart' as aspen;
import 'package:vue2/vue.dart';
import 'package:vue2/plugins/vuematerial.dart';

import 'package:blockbyte/embedded_image.dart';
import 'package:blockbyte/link_header.dart';
import 'package:blockbyte/site_navbar.dart';
import 'package:blockbyte/site_title.dart';
import 'package:blockbyte/site_suffix.dart';
import 'package:blockbyte/site_tags.dart';

import 'package:js/js.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:html';


Future<List<String>> getPosts() async {
  var str = await HttpRequest.getString('/posts.json');
  return new Future.value(JSON.decode(str)['posts'] as List<String>);
}


Future<Document> getPost(String url) async {
  var str = await HttpRequest.getString(url);
  return new DomParser().parseFromString(str, 'text/html');
}


void appendStyle(String href) {
  var style = new LinkElement();
  style.rel = 'stylesheet';
  style.href = href;
  document.head.append(style);
}


void appendScript(String src) {
  var script = new ScriptElement();
  script.src = src;
  document.head.append(script);
}


ScriptElement muutjs;


Future init() async {
  VueConfig.ignoredElements = ['share-button'];

  appendStyle('https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,400italic');

  await initVue();

  VueMaterial.use();
  VueMaterial.registerTheme('main', new MdTheme(
    primary: 'indigo',
    accent: new MdColor(color: 'blue', hue: 900),
    warn: 'red',
    background: 'white',
  ));
  VueMaterial.setCurrentTheme('main');

  return new Future.value();
}

