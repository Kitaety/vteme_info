import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:test_app/common/icons_vteme_icons.dart';
import 'package:test_app/ui/currency_converter_screen/converter_list_item.dart';
import 'package:test_app/data/currency.dart';
import 'package:test_app/ui/currency_converter_screen/currency_converter_screen_wm.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class CurrencyConverterScreen extends StatefulWidget {
  CurrencyConverterScreen({Key key}) : super(key: key);
  final CurrencyConverterScreenWM wm = CurrencyConverterScreenWM();

  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  bool select = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.wm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text(
          "Конвертер валют",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: _buildInfoBlock(),
            ),
            Expanded(
                flex: 8,
                child: Container(
                    child: EntityStateBuilder(
                  streamedState: widget.wm.currencyState,
                  loadingChild: Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                  child: (context, List<Currency> list) => ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) =>
                        StreamedStateBuilder<Object>(
                            streamedState: widget.wm.selectedIndex,
                            builder: (context, snapshot) {
                              return InkWell(
                                onTap: () {
                                  widget.wm.changeSelectIndex.accept(index);
                                },
                                child: Container(
                                  color: index == snapshot
                                      ? Colors.purple[50]
                                      : null,
                                  child: StreamedStateBuilder<Object>(
                                    streamedState: widget.wm.selectText,
                                    builder: (context, text) =>
                                        ConverterListItem(
                                      currency: list[index],
                                      text: index == snapshot ? text : null,
                                    ),
                                  ),
                                ),
                              );
                            }),
                  ),
                ))),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.grey[300],
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 22,
                      child: _buildActionButton(),
                    ),
                    Expanded(
                      flex: 22,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildButton("7"),
                            _buildButton("4"),
                            _buildButton("1"),
                            _buildButton("0"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 22,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildButton("8"),
                            _buildButton("5"),
                            _buildButton("2"),
                            _buildButton(","),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 22,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildButton("9"),
                            _buildButton("6"),
                            _buildButton("3"),
                            _buildDeleteButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: RaisedButton(
          onPressed: () {
            widget.wm.tapKey.accept(text);
          },
          color: Theme.of(context).accentColor,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveFlutter.of(context).fontSize(5),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBlock() {
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.error_outline,
            size: ResponsiveFlutter.of(context).scale(20),
            color: Colors.grey[700],
          ),
          Text(
            "Информация предоставлена ресурсом www.nbrb.by",
            style: TextStyle(
              fontSize: ResponsiveFlutter.of(context).fontSize(1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: RaisedButton(
          onPressed: () {
            widget.wm.tapKey.accept('d');
          },
          color: Theme.of(context).accentColor,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: Center(
              child: Icon(
            Icons.backspace_outlined,
            color: Colors.white,
            size: ResponsiveFlutter.of(context).scale(30),
          )),
        ),
      ),
    );
  }

  _buildActionButton() {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: RaisedButton(
                onPressed: () {
                  widget.wm.tapKey("c");
                },
                color: Colors.red[200],
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    "C",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveFlutter.of(context).fontSize(7),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: RaisedButton(
                onPressed: () {
                  widget.wm.tapOnAddBtn();
                },
                color: Colors.orange[300],
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        IconsVteme.currency,
                        color: Colors.white,
                        size: ResponsiveFlutter.of(context).scale(40),
                      ),
                      Container(
                        height: 5,
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: ResponsiveFlutter.of(context).scale(25),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
