import 'package:flutter/material.dart';

//TODO доделать баннер
class VipAdBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image(
          image: AssetImage("assets/images/rus.jpg"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
