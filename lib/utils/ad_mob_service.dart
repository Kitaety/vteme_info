import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vteme_info/ui/main_screen/pages/news_article/vip_ad_block.dart';

class AdMobService {
  Future<InitializationStatus> initializationStatus;
  List<String> _vipBanners = [
    "assets/images/rus.jpg",
  ];
  int _currentVipBanner = 0;
  AdMobService(this.initializationStatus);
  //TODO ios ads
  String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      //: 'ca-app-pub-3940256099942544/2934735716';
      : '';
  AdListener get adListener => _adListener;
  AdListener _adListener = AdListener(
    onAdLoaded: (ad) => print("Ad loaded: ${ad.adUnitId}."),
  );

  Widget getVipBanner() {
    if (_currentVipBanner < _vipBanners.length) {
      _currentVipBanner++;
      return VipAdBlock(_vipBanners[_currentVipBanner - 1]);
    } else {
      BannerAd banner = BannerAd(
          adUnitId: bannerAdUnitId,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adListener)
        ..load();
      return Container(height: 50, child: AdWidget(ad: banner));
    }
  }
}
