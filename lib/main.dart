import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// グローバル変数としてプラグインのインスタンスを作成
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  // プラグインの初期化が完了するまでWidgetのバインディングを確保
  WidgetsFlutterBinding.ensureInitialized();
  
  // タイムゾーンの初期化
  tz_data.initializeTimeZones();

  // 通知の初期化
  await initNotifications();

  runApp(const MyApp());
}

// 通知の初期化処理
Future<void> initNotifications() async {
  // Androidの初期設定
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
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  // プラグインの初期化
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (
      NotificationResponse notificationResponse,
    ) {
      // 通知がタップされたときの処理
      debugPrint('通知がタップされました: ${notificationResponse.payload}');
      // ここで特定の画面に遷移させるなどの処理を行うことができます
    },
  );

  // Android 13以降のために必要な通知許可の要求
  await requestNotificationPermissions();
}

// 通知許可を要求する関数
Future<void> requestNotificationPermissions() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.requestNotificationsPermission();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '通知サンプル',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NotificationScreen(),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('通知サンプル')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => showBasicNotification(),
              child: const Text('基本的な通知を表示'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showScheduledNotification(),
              child: const Text('予定された通知を表示 (5秒後)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showBigPictureNotification(),
              child: const Text('画像付き通知を表示 (Androidのみ)'),
            ),
          ],
        ),
      ),
    );
  }

  // 基本的な通知を表示
  Future<void> showBasicNotification() async {
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
  Future<void> showScheduledNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'scheduled_channel',
          'Scheduled Notifications',
          channelDescription: '予定された通知のチャンネルです',
          importance: Importance.max,
          priority: Priority.high,
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // 現在時刻から5秒後に通知をスケジュール
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '予定された通知',
      '指定時間に表示される通知です',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'schedule_channel',
          'スケジュール通知',
          channelDescription: 'スケジュールされた通知のチャンネルです',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // 画像付き通知を表示 (Androidのみ)
  Future<void> showBigPictureNotification() async {
    // Androidのみ対応する機能
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
          const DrawableResourceAndroidBitmap(
            '@mipmap/ic_launcher',
          ), // アプリのアイコンを使用
          largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          contentTitle: '拡張通知のタイトル',
          summaryText: '通知の概要テキスト',
          htmlFormatContent: true,
          htmlFormatContentTitle: true,
        );

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'big_picture_channel',
          'Big Picture Notifications',
          channelDescription: '画像付き通知のチャンネルです',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: bigPictureStyleInformation,
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      2, // 通知ID
      '画像付き通知',
      'これは画像付きの通知です (Androidのみ)',
      platformChannelSpecifics,
      payload: 'big_picture_notification',
    );
  }
}
