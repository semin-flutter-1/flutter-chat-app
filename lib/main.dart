import 'package:chat_app/repository/firebase/firebase_user_repository.dart';
import 'package:chat_app/repository/firebase/firestore_chat_repository.dart';
import 'package:chat_app/ui/chat/chat_page.dart';
import 'package:chat_app/ui/login/login_page.dart';
import 'package:chat_app/viewmodel/chat_view_model.dart';
import 'package:chat_app/viewmodel/login_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

Future<void> _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          'This channel is used for important notifications.', // description
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('slow_spring_board'),
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    message.data['title'],
    message.data['body'],
    platformChannelSpecifics,
    payload: 'item x',
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  _showNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp();

  final userRepository = FirebaseUserRepository();
  // final chatRepository = FirebaseChatRepository();

  final chatRepository = FirestoreChatRepository();

  // final userRepository = FakeUserRepository();
  // final chatRepository = FakeChatRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: LoginViewModel(userRepository: userRepository)),
        ChangeNotifierProvider.value(value: ChatViewModel(chatRepository)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.amber),
        ),
      ),
      home: viewModel.user != null ? ChatPage() : LoginPage(),
    );
  }
}
