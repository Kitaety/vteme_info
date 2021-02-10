import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/ui/app.dart';
import 'common/error_handler.dart';
import 'utils/web_services.dart';
import 'package:flutter/services.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
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
          ));
}

/// Log errors
class DefaultErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint(e.toString());
  }
}
