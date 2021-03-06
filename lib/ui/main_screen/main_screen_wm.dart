import 'package:flutter/material.dart';
import 'package:relation/relation.dart' as r;
import 'package:vteme_info/common/error_handler.dart';
import 'package:vteme_info/common/widget_model.dart';

const int defaultPageIndex = 2;

class MainScreenWM extends WidgetModel {
  final pageIndexState = r.StreamedState<int>(defaultPageIndex);
  final changePageAction = r.Action<int>();
  final titleAppBarState = r.StreamedState<Widget>();

  MainScreenWM() : super(errorHandler: MainScreenErrorHandler()) {
    subscribe(changePageAction.stream, onChangePage);
  }

  void onChangePage(int pageIndex) {
    pageIndexState.accept(pageIndex);
  }

  void onChangeTitleAppBar(Widget title) {
    titleAppBarState.accept(title);
  }
}

class MainScreenErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('[Main Screen]:${e.toString()}');
  }
}
