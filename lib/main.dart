import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/ui/app.dart';
import 'common/error_handler.dart';
import 'utils/web_services.dart';

void main() {
  runApp(
    Provider(
      create: (_) => {},
      child: MultiProvider(
        providers: [
          Provider(create: (context) => WebServices()),
          Provider(
            create: (context) => Navigator.of(context),
          )
        ],
        child: App(),
      ),
    ),
  );
}

/// Log errors
class DefaultErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint(e.toString());
  }
}
