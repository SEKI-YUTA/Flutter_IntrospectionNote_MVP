import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:introspection_note_mvp/data/sharedpref/SharedPreferenceHelper.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationUtil {
  NotificationUtil._privateConstructor();
  static final NotificationUtil instance =
      NotificationUtil._privateConstructor();

  Future<bool> requestPermissions() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    bool? result = false;
    if (Platform.isIOS || Platform.isMacOS) {
      result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      result = await androidImplementation?.requestNotificationsPermission();
    }
    print("requestPermissions: $result");
    return result ?? false;
  }

  Future<void> initNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // アプリのアイコンを使用

    // iOSの初期設定
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true, // アラート許可を要求
          requestBadgePermission: true, // バッジ許可を要求
          requestSoundPermission: true, // サウンド許可を要求
        );

    // 初期化設定を作成
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    // プラグインの初期化
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) {
        debugPrint('通知がタップされました: ${notificationResponse.payload}');
      },
    );
  }

  Future<void> showBasicNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'basic_channel', // チャンネルID
          'Basic Notifications', // チャンネル名
          channelDescription: '基本的な通知のチャンネルです', // チャンネルの説明
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // 通知ID (同じIDの通知は上書きされる)
      '基本通知', // 通知のタイトル
      'これは基本的な通知メッセージです', // 通知の内容
      platformChannelSpecifics,
      payload: 'basic_notification', // タップしたときに使用できるデータ
    );
  }

  // スケジュールされた通知を表示
  Future<void> showScheduledNotification(
    int notificationId,
    int hour,
    int minute,
  ) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    tz.TZDateTime scheduledDate = _getNextDateTime(hour, minute);
    print(scheduledDate);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'scheduled_channel',
          'Scheduled Notifications',
          channelDescription: '内省を書くのをリマインドする通知のチャンネルです',
          importance: Importance.max,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      '今日の内省は書きましたか？',
      '今日を振り返って明日への準備をしましょう',
      scheduledDate,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int notificationId) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> enableRemindNotification() async {
    print("enableRemindNotification");
    String remindTime = await SharedpreferenceHelper.instance.getString(
      SharedpreferenceHelper.SETTING_PUSH_NOTIFICATION_TIME,
    );
    List<String> time = remindTime.split(":");
    if (time.length != 2) {
      time = ["20", "00"];
    }
    print(time);
    int notificationId = await SharedpreferenceHelper.instance.getInt(
      SharedpreferenceHelper.SETTING_PUSH_NOTIFICATION_ID,
    );
    print(notificationId);
    NotificationUtil.instance.showScheduledNotification(
      notificationId,
      int.parse(time[0]),
      int.parse(time[1]),
    );
  }

  Future<void> disableRemindNotification() async {
    int notificationId = await SharedpreferenceHelper.instance.getInt(
      SharedpreferenceHelper.SETTING_PUSH_NOTIFICATION_ID,
    );
    NotificationUtil.instance.cancelNotification(notificationId);
  }

  tz.TZDateTime _getNextDateTime(int hour, int minute) {
    final japanTimeZone = tz.getLocation('Asia/Tokyo');

    // 現在の日本時間を取得
    final currentJapanTime = tz.TZDateTime.now(japanTimeZone);

    // 今日の指定時刻
    final todays = tz.TZDateTime(
      japanTimeZone,
      currentJapanTime.year,
      currentJapanTime.month,
      currentJapanTime.day,
      hour,
      minute,
      0,
    );

    if (currentJapanTime.isAfter(todays)) {
      return tz.TZDateTime(
        japanTimeZone,
        currentJapanTime.year,
        currentJapanTime.month,
        currentJapanTime.day + 1, // 翌日
        hour,
        minute,
        0,
      );
    } else {
      return todays;
    }
  }
}
