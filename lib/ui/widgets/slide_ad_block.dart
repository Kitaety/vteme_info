import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';

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
      Container(
        color: Colors.blue,
        child: Center(
          child: Text("bbb"),
        ),
      )
    ][index];
  }
}
