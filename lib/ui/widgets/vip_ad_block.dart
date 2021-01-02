import 'package:flutter/material.dart';
import 'package:test_app/widget_model/widgets/vip_ad_block_wm.dart';

class VipAdBlock extends StatelessWidget {
  VipAdBlockWM wm;

  VipAdBlock({Key key, @required VipAdBlockWM widgetModel}) : super(key: key) {
    this.wm = widgetModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      child: Center(
        child: Text("VIP реклама"),
      ),
    );
  }
}
