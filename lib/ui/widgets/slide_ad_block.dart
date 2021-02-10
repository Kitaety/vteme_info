import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:native_ads/native_ad_param.dart';
import 'package:native_ads/native_ad_view.dart';

class SlideAdBlock extends StatefulWidget {
  @override
  _SlideAdBlockState createState() => _SlideAdBlockState();
}

class _SlideAdBlockState extends State<SlideAdBlock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 2),
      child: BannerSwiper(
          height: 100,
          width: 80,
          autoLoop: true,
          spaceMode: false,
          length: 2,
          getwidget: (index) {
            return getChildren(context, index % 2);
          }),
    );
  }

  Widget getChildren(context, index) {
    return [
      Container(
        child: Text("aa"),
      ),
      // Container(
      //     color: Colors.red,
      //     child: NativeAdView(
      //       androidParam: AndroidParam()
      //         ..placementId = "ca-app-pub-1774878275661991/7408321775"
      //         ..packageName = "com.example.test_app"
      //         ..layoutName = "ad_banner"
      //         ..attributionText = "AD",
      //     )),
      Container(
        color: Colors.blue,
        child: Center(
          child: Text("bbb"),
        ),
      )
    ][index];
  }
}
