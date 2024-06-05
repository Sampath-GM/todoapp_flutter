import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/pages/HomePage.dart';
import 'package:todoapp/pages/registerpage.dart';
import 'package:todoapp/pages/loginpage.dart';
import 'package:todoapp/pages/TodoHome.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  runApp(
    MyApp(
      token:pref.getString('token')
      ));
}

class MyApp extends StatelessWidget {

  final token;
  const MyApp({
    @required this.token,
    super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home:RegisterPage()
      // (JwtDecoder.isExpired(token) == false)?Homepage(token: token) :const Loginpage() 
    );
  }
}