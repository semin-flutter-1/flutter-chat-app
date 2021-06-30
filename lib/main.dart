import 'package:chat_app/repository/fake/fake_chat_repository.dart';
import 'package:chat_app/repository/fake/fake_user_repository.dart';
import 'package:chat_app/ui/chat/chat_page.dart';
import 'package:chat_app/ui/login/login_page.dart';
import 'package:chat_app/viewmodel/chat_view_model.dart';
import 'package:chat_app/viewmodel/login_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // final userRepository = FirebaseUserRepository();
  // final chatRepository = FirebaseChatRepository();

  // final chatRepository = FirestoreChatRepository();

  final userRepository = FakeUserRepository();
  final chatRepository = FakeChatRepository();

  Get.put(LoginViewModel(userRepository));
  Get.put(ChatViewModel(chatRepository));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final viewModel = Get.find<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetBuilder<LoginViewModel>(
        builder: (_) {
          return viewModel.user != null ? ChatPage() : LoginPage();
        },
      ),
    );
  }
}
