import 'package:flutter/material.dart';
import 'package:flutter_task/Screens/screen_A.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
      debugShowCheckedModeBanner: false,
      home: ScreenA(),
    );
  }
}

