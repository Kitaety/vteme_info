import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PrimaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final Color color;
  final Widget title;

  const PrimaryAppBar({
    Key key,
    this.height,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  _PrimaryAppBarState createState() => _PrimaryAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(this.height != null ? this.height : 60);
}

class _PrimaryAppBarState extends State<PrimaryAppBar> {
  bool _switchState = false;

  void _onChangeStateSwitch(bool state) {
    setState(() {
      _switchState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      iconTheme: IconThemeData(
        color: Theme.of(context).accentColor,
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: Row(children: [
            FlutterSwitch(
              height:30,
              width: 60,
              valueFontSize: 15.0,
              toggleSize: 18.0,
              value: _switchState,
              onToggle: _onChangeStateSwitch,
              showOnOff: true,
              inactiveText: "RU",
              activeText: "EN",
              activeColor: Theme.of(context).accentColor,
              inactiveTextColor: Colors.white,
              activeTextColor: Colors.white,
            ),
          ]),
        ),
      ],
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Container(
//     height: widget.height,
//     decoration: BoxDecoration(
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.4),
//           spreadRadius: 1,
//           blurRadius: 4,
//           offset: Offset(0, 1), // changes position of shadow
//         ),
//       ],
//     ),
//     child: Container(
//       color: widget.color != null
//           ? widget.color
//           : Theme.of(context).primaryColor,
//       child: SizedBox(
//         width: double.infinity,
//         child: Row(
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.menu),
//               color: Theme.of(context).accentColor,
//               highlightColor: Colors.transparent,
//               splashColor: Colors.transparent,
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//             ),
//             Expanded(
//               child: Container(
//                 alignment: Alignment.center,
//                 child: widget.title,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child:
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
