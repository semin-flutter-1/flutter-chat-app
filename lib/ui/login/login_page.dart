
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        height: 50,
        width: 200,
        child: Center(child: Text('Google',style: TextStyle(fontSize: 25,color: Colors.white),)),
        decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)
            )
        ),

      ),),
    );
  }
}
