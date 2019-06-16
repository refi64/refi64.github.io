import 'package:aspen/aspen.dart';
import 'package:aspen_assets/aspen_assets.dart';
import 'package:aspen_web/aspen_web.dart';

import 'assets.g.dart' as assets_g;

@Asset('asset:blockbyte/node_modules/vue/dist/vue.js',
       release: 'asset:blockbyte/node_modules/vue/dist/vue.min.js')
const vueJs = JsAsset(text: assets_g.vueJs$content);

@Asset('asset:blockbyte/node_modules/whendefined/dist/whendefined.js',
       release: 'asset:blockbyte/node_modules/whendefined/dist/whendefined.min.js')
const whendefinedJs = JsAsset(text: assets_g.whendefinedJs$content);

@Asset('asset:blockbyte/node_modules/better-share-button/dist/share-button.js',
       release: 'asset:blockbyte/node_modules/better-share-button/dist/share-button.min.js')
const shareButtonJs = JsAsset(text: assets_g.shareButtonJs$content);

@Asset('asset:blockbyte/node_modules/better-share-button/dist/share-button.css',
       release: 'asset:blockbyte/node_modules/better-share-button/dist/share-button.min.css')
const shareButtonCss = CssAsset(text: assets_g.shareButtonCss$content);

@Asset('asset:blockbyte/web/analytics.js')
const analyticsJs = JsAsset(text: assets_g.analyticsJs$content);

@Asset('asset:blockbyte/web/dist/pygments.css')
const pygmentsCss = CssAsset(text: assets_g.pygmentsCss$content);
