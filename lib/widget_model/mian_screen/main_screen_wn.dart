import 'package:flutter/material.dart';
import 'package:relation/relation.dart' as r;
import 'package:test_app/common/error_handler.dart';
import 'package:test_app/utils/widget_model.dart';

const int defaultPageIndex = 2;

class MainScreenWM  extends WidgetModel{

  final pageIndexState = r.StreamedState<int>(defaultPageIndex);
  final changePageAction = r.Action<int>();


  MainScreenWM():super(errorHandler: MainScreenErrorHandler()){
    subscribe(changePageAction.stream,onChangePage);
  }

  void onChangePage(int pageIndex) {
    pageIndexState.accept(pageIndex);
  }
}

class MainScreenErrorHandler extends ErrorHandler{
  @override
  void handleError(Object e) {
    debugPrint('[Main Screen]:${e.toString()}');
  }
}
