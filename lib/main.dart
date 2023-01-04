import 'package:flutter/material.dart';
import './screen/weight_screen.dart';
import 'package:provider/provider.dart';
import './provider/weight_input.dart';
import 'package:firebase_core/firebase_core.dart';
import './screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> WeightInput() ,
      child: MaterialApp(
        routes: {
          "home" : (context) => WeightList(),
          "login": (context) => Login()
        },
        home: Login(),
      ),
    );
  }
}

