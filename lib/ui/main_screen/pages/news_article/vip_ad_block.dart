import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

//TODO доделать баннер
class VipAdBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveFlutter.of(context).scale(330),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image(
            image: AssetImage("assets/images/rus.jpg"),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
