import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notifs;
import 'package:rxdart/subjects.dart' as rxSub;
import 'package:vteme_info/data/note.dart';
import 'package:vteme_info/ui/note_screen/note_screen_wm.dart';
import 'package:vteme_info/utils/navigation_service.dart';
import 'package:vteme_info/utils/note_storege_service.dart';

final rxSub.BehaviorSubject<NotificationClass>
    didReceiveLocalNotificationSubject =
    rxSub.BehaviorSubject<NotificationClass>();
final rxSub.BehaviorSubject<String> selectNotificationSubject =
    rxSub.BehaviorSubject<String>();

class NotificationClass {
  final int id;
  final String title;
  final String body;
  final String payload;
  NotificationClass({this.id, this.body, this.payload, this.title});
}

Future<void> initNotifications(
    notifs.FlutterLocalNotificationsPlugin notifsPlugin) async {
  var initializationSettingsAndroid =
      notifs.AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = notifs.IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(NotificationClass(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = notifs.InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await notifsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      String strID = payload.split('@')[1];
      print(payload);
      if (strID.isNotEmpty) {
        int id = int.parse(strID);
        Note note = await NoteStoregeService.getNote(id: id);
        NavigationService.instance.navigateToReplacement("screen_note",
            arguments: NoteArgs(NoteMode.Editing, note));
      }
    }
    selectNotificationSubject.add(payload);
  });
  print("Notifications initialised successfully");
}

void requestIOSPermissions(
    notifs.FlutterLocalNotificationsPlugin notifsPlugin) {
  notifsPlugin
      .resolvePlatformSpecificImplementation<
          notifs.IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

Future<void> scheduleNotification(
    {notifs.FlutterLocalNotificationsPlugin notifsPlugin,
    int id,
    String title,
    String body,
    DateTime scheduledTime}) async {
  var androidSpecifics = notifs.AndroidNotificationDetails(
    id.toString(), // This specifies the ID of the Notification
    'Scheduled notification', // This specifies the name of the notification channel
    'A scheduled notification', //This specifies the description of the channel
    icon: '@mipmap/ic_launcher',
  );
  var iOSSpecifics = notifs.IOSNotificationDetails();
  var platformChannelSpecifics =
      notifs.NotificationDetails(android: androidSpecifics, iOS: iOSSpecifics);
  await notifsPlugin.schedule(
      id, title, body, scheduledTime, platformChannelSpecifics,
      payload:
          "$scheduledTime@$id"); // This literally schedules the notification
}

Future<void> cancelNotification(
    notifs.FlutterLocalNotificationsPlugin notifsPlugin, int id) async {
  await notifsPlugin.cancel(id);
}

Future<DateTime> getDateTimeNotification(
    notifs.FlutterLocalNotificationsPlugin notifsPlugin, int id) async {
  List<notifs.PendingNotificationRequest> notifications =
      await notifsPlugin.pendingNotificationRequests();
  for (var notification in notifications) {
    if (notification.id == id) {
      return DateTime.parse(notification.payload.split('@')[0]);
    }
  }
  return null;
}
