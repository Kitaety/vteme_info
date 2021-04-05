import 'package:flutter/material.dart';

class LeftMenuHeader extends StatefulWidget {
  @override
  _LeftMenuHeaderState createState() => _LeftMenuHeaderState();
}

class _LeftMenuHeaderState extends State<LeftMenuHeader> {
  bool _isLogin = false;

  void _onTapSingBut() {
    setState(() {
      _isLogin = true;
    });
  }

  void _onTapProfileBut() {
    setState(() {
      _isLogin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
            child: Row(
              children: <Widget>[
                const Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 130,
                  fit: BoxFit.fitHeight,
                ),
                Expanded(
                  child: Container(
                    height: 140,
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Container(
                          child: !_isLogin
                              ? Container(
                                  child: ButtonTheme(
                                    minWidth: double.infinity,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Theme.of(context)
                                                      .accentColor),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.0),
                                            ),
                                          ),
                                          textStyle: MaterialStateProperty.all<
                                              TextStyle>(
                                            TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          )),
                                      onPressed: _onTapSingBut,
                                      child: Text("Войти"),
                                    ),
                                  ),
                                )
                              : Material(
                                  color: Theme.of(context).primaryColor,
                                  child: InkWell(
                                    onTap: _onTapProfileBut,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            radius: 15,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Мой профиль",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                  ),
                                                  Text(
                                                    "danilovitch.ev@gmail.com",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ), // child:
                          alignment: Alignment.center,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Справочно - информационный каталог твоего города",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
          width: double.infinity,
          child: Container(
            color: Colors.black,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("бегущая строка",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
