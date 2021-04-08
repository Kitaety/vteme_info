import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:vteme_info/ui/app.dart';
import 'package:vteme_info/utils/ad_mob_service.dart';
import 'common/error_handler.dart';
import 'utils/notifications_helper.dart';
import 'utils/web_services.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

NotificationAppLaunchDetails notifLaunch;
final FlutterLocalNotificationsPlugin notifsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  //реклама
  final initFuture = MobileAds.instance.initialize();
  final admobServise = AdMobService(initFuture);
  //уведомления
  notifLaunch = await notifsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(notifsPlugin);
  requestIOSPermissions(notifsPlugin);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
            Provider.value(
              value: admobServise,
              child: MultiProvider(
                  providers: [
                    Provider(create: (context) => WebServices()),
                    Provider(
                      create: (context) => Navigator.of(context),
                    )
                  ],
                  child: EasyLocalization(
                    supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
                    path: 'assets/translations',
                    fallbackLocale: Locale('en', 'US'),
                    child: App(),
                  )),
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
