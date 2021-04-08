import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:vteme_info/utils/ad_mob_service.dart';

class SlideAdBlock extends StatefulWidget {
  @override
  _SlideAdBlockState createState() => _SlideAdBlockState();
}

class _SlideAdBlockState extends State<SlideAdBlock> {
  BannerAd _bannerAdOne;
  BannerAd _bannerAdTwo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adMobService = Provider.of<AdMobService>(context);
    adMobService.initializationStatus.then((status) {
      setState(() {
        _bannerAdOne = BannerAd(
            adUnitId: adMobService.bannerAdUnitId,
            size: AdSize.banner,
            request: AdRequest(),
            listener: adMobService.adListener)
          ..load();
        _bannerAdTwo = BannerAd(
            adUnitId: adMobService.bannerAdUnitId,
            size: AdSize.banner,
            request: AdRequest(),
            listener: adMobService.adListener)
          ..load();
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerAdOne != null && _bannerAdTwo != null
        ? Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 2),
            child: BannerSwiper(
              height: 50,
              width: 80,
              autoLoop: true,
              spaceMode: false,
              length: 2,
              showIndicator: false,
              getwidget: (index) {
                return getChildren(context, index % 2);
              },
            ))
        : Container();
  }

  Widget getChildren(context, index) {
    return [
      Container(
        child: AdWidget(ad: _bannerAdOne),
      ),
      Container(child: AdWidget(ad: _bannerAdTwo))
    ][index];
  }
}
