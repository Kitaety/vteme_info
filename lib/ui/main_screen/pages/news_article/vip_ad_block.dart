import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class VipAdBlock extends StatelessWidget {
  final String img;

  VipAdBlock(this.img);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveFlutter.of(context).scale(330),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image(
            image: AssetImage(img),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
