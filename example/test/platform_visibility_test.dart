import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Android visibility contains every queried package exactly once', () async {
    final manifest = await File('android/app/src/main/AndroidManifest.xml').readAsString();
    const packages = [
      'com.linkedin.android',
      'com.instagram.android',
      'com.whatsapp',
      'org.telegram.messenger',
      'com.facebook.katana',
      'com.google.android.youtube',
      'com.twitter.android',
      'com.instagram.barcelona',
      'com.pinterest',
      'com.zhiliaoapp.musically',
      'us.zoom.videomeetings',
      'com.Slack',
      'com.google.android.apps.maps',
      'com.waze',
      'com.sygic.aura',
      'org.rajman.neshan.traffic.tehran.navigator',
      'com.autonavi.minimap',
      'com.tranzmate',
      'com.baidu.BaiduMap',
      'ru.dublgis.dgismobile',
      'ru.yandex.yandexmaps',
      'ru.yandex.yandexnavi',
      'com.android.vending',
      'com.huawei.appmarket',
      'com.farsitel.bazaar',
      'ir.mservices.market',
    ];
    for (final package in packages) {
      expect(_occurrences(manifest, '<package android:name="$package" />'), 1, reason: package);
    }
  });

  test('Android visibility contains the Yandex Navigator scheme exactly once', () async {
    final manifest = await File('android/app/src/main/AndroidManifest.xml').readAsString();

    expect(_occurrences(manifest, '<data android:scheme="yandexnavi" />'), 1);
  });

  test('iOS visibility contains every queried scheme exactly once', () async {
    final infoPlist = await File('ios/Runner/Info.plist').readAsString();
    const schemes = [
      'instagram',
      'tg',
      'fb',
      'whatsapp',
      'linkedin',
      'youtube',
      'twitter',
      'pinterest',
      'tiktok',
      'zoomus',
      'slack',
      'comgooglemaps',
      'waze',
      'maps',
      'com.sygic.aura',
      'barcelona',
      'neshan',
      'iosamap',
      'moovit',
      'baidumap',
      'dgis',
      'yandexmaps',
      'yandexnavi',
      'itms-apps',
    ];
    for (final scheme in schemes) {
      expect(_occurrences(infoPlist, '<string>$scheme</string>'), 1, reason: scheme);
    }
  });
}

int _occurrences(final String source, final String value) => RegExp(RegExp.escape(value)).allMatches(source).length;
