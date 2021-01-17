import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:test_app/utils/ad_mob_service.dart';

class SlideAdBlock extends StatefulWidget {
  @override
  _SlideAdBlockState createState() => _SlideAdBlockState();
}

class _SlideAdBlockState extends State<SlideAdBlock> {
  final ams = new AdModService();

  final _children = [
    Container(
      color: Colors.red,
      child: Center(
        child: Text("aaa"),
      ),
    ),
    Container(
      color: Colors.blue,
      child: Center(
        child: Text("bbb"),
      ),
    )
  ];

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
          length: _children.length,
          getwidget: (index) {
            return _children[index % _children.length];
          }),
    );
  }
}
