import 'package:chat_app/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<LoginViewModel>().login();
          },
          child: Text('Log In'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey),
          ),
        ),
      ),
    );
  }
}
