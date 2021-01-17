import 'package:flutter/material.dart';
import 'package:test_app/common/error_handler.dart';
import 'package:relation/relation.dart' as r;
import 'package:test_app/common/widget_model.dart';

//TODO Сделать внутреннюю логику вип рекламы
class VipAdBlockWM extends WidgetModel {
  VipAdBlockWM() : super(errorHandler: VipAdBlockErrorHandler());
}

class VipAdBlockErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint("[VIP Ad block]: ${e.toString()}");
  }
}
