// @dart=2.9
import 'dart:collection';
// ignore: import_of_legacy_library_into_null_safe
import 'package:html/dom.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:html/parser.dart' show parse;
import 'package:rssaid/common/common.dart';

import 'package:rssaid/models/radar.dart';
import 'package:rssaid/radar/rules.dart';


class RssPlus {


  static Future<List<Radar>> detecting(String url) async {
    var specialRadar = Rules.detectUrl(url);
    if (specialRadar != null) {
      return specialRadar;
    }

    return await detectByUrl(url);
  }

  static Future<List<Radar>> detectByUrl(String url) async {
    List<Radar> radarList = [];
    String html = await Common.getContentByUrl(Uri.parse(url));
    Document document = parse(html);
    try {
      radarList = await parseKnowedRss(document, url);
      radarList += await parseUnKnowedRss(document, url);
      radarList = radarList.toSet().toList();
    } catch (e) {
      print("parseRss error:$e");
    }
    return radarList;
  }

  /// 获取在<head>的<link>元素中，已经声明为RSS的链接
  static Future<List<Radar>> parseKnowedRss(
      Document document, String url) async {
    List<Radar> radarList =[];
    List<Element> links = document.getElementsByTagName("link");
    for (var i = 0; i < links.length; i++) {
      var link = links[i];
      if (link != null) {
        LinkedHashMap attrs = link.attributes;
        String linkHref = attrs['href'];
        String linkType = attrs['type'];
        String linkTitle = attrs.containsKey("title")
            ? attrs['title']
            : document.getElementsByTagName("title")[0].text;
        RegExp rssPattern = new RegExp(r'.+\/(rss|rdf|atom)');
        RegExp xmlPattern = new RegExp(r'^text\/xml$');
        if (linkType != null &&
            linkType.isNotEmpty &&
            (rssPattern.hasMatch(linkType) || xmlPattern.hasMatch(linkType))) {
          Uri uri = Uri.parse(url);
          if (!linkHref.startsWith("http") && !linkHref.contains(uri.host)) {
            linkHref = '${uri.scheme}://${uri.host}$linkHref';
          }
          Radar radar = new Radar.fromJson(
              {"title": linkTitle, "path": linkHref, "isRssHub": false});
          radarList.add(radar);
        }
      }
    }
    return radarList;
  }

  static Future<List<Radar>> parseUnKnowedRss(
      Document document, String url) async {
    List<Element> links = document.getElementsByTagName("a");
    List<Radar> radarList = [];
    Uri uri = Uri.parse(url);

    for (var i = 0; i < links.length; i++) {
      var link = links[i];
      if (link != null) {
        LinkedHashMap attrs = link.attributes;
        String linkHref = attrs['href'];
        String linkTitle =
            attrs.containsKey("title") ? attrs['title'] : link.text;
        if (linkTitle.isEmpty) {
          linkTitle = document.getElementsByTagName("title")[0].text;
        }
        if (linkHref != null &&
            (new RegExp(r'^(https|http|ftp|feed).*([\.\/]rss([\.\/]xml|\.aspx|\.jsp|\/)?$|\/node\/feed$|\/feed(\.xml|\/$|$)|\/rss\/[a-z0-9]+$|[?&;](rss|xml)=|[?&;]feed=rss[0-9.]*$|[?&;]action=rss_rc$|feeds\.feedburner\.com\/[\w\W]+$)')
                    .hasMatch(linkHref) ||
                new RegExp(
                        r'^(https|http|ftp|feed).*\/atom(\.xml|\.aspx|\.jsp|\/)?$|[?&;]feed=atom[0-9.]*$')
                    .hasMatch(linkHref) ||
                new RegExp(
                        r'^(https|http|ftp|feed).*(\/feeds?\/[^.\/]*\.xml$|.*\/index\.xml$|feed\/msgs\.xml(\?num=\d+)?$)')
                    .hasMatch(linkHref) ||
                new RegExp(r'^(https|http|ftp|feed).*\.rdf$')
                    .hasMatch(linkHref) ||
                new RegExp(r'^(rss|feed):\/\/').hasMatch(linkHref) ||
                new RegExp(r'^(https|http):\/\/feed\.').hasMatch(linkHref))) {
          if (!linkHref.startsWith("http") && !linkHref.contains(uri.host)) {
            linkHref = '${uri.scheme}://${uri.host}$linkHref';
          }
          Radar radar = new Radar.fromJson(
              {"title": linkTitle, "path": linkHref, "isRssHub": false});
          radarList.add(radar);
        }
      }
    }
    return radarList;
  }
}
