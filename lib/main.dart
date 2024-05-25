import 'package:flutter/material.dart';
import 'package:todoapp/pages/registerpage.dart';
import 'package:todoapp/pages/loginpage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: 
       RegisterPage(),
    );
  }
}