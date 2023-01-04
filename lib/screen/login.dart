import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          child: TextButton(
              onPressed: () async {
                try {
                  final user = await FirebaseAuth.instance.signInAnonymously();
                  Navigator.pushReplacementNamed(context, "home");
                }catch(e) {
                  print(e);
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                child: Center(child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20),)),
              )
          ),
        ),
      ),
    );
  }
}
