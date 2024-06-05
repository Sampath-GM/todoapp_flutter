import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/constants/url.dart';
import 'package:todoapp/pages/HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/pages/registerpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isNotValidated = false;
  late SharedPreferences _preferences;
  String _loginError = '';

  @override
  void initState() {
    super.initState();
    _initSharedPref();
  }

  Future<void> _initSharedPref() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> _loginUser() async {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      final String url = Uri.parse(ApiEndpoints.login).toString();
      final Map<String, String> reqBody = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] as bool) {
          final String myToken = jsonResponse['token'];
          await _preferences.setString('token', myToken);
          if (!JwtDecoder.isExpired(myToken)) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homepage(token: myToken)),
            );
          } else {
            setState(() {
              _loginError = "Token has expired.";
            });
          }
        } else {
          setState(() {
            _loginError = "Invalid login credentials.";
          });
        }
      } else {
        setState(() {
          _isNotValidated = true;
          _loginError = "Error: ${response.statusCode}";
        });
      }
    } else {
      setState(() {
        _isNotValidated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/Login.png',
                  height: 250,
                  width: 250,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      errorText: _isNotValidated ? "Please enter your email." : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      errorText: _isNotValidated ? "Please enter your password." : null,
                    ),
                  ),
                ),
                if (_loginError.isNotEmpty)
                  Text(
                    _loginError,
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _loginUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                  ),
                  child: Container(
                    width: 230,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // Navigate to Register page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: RichText(
                    text:  TextSpan(
                      text: "Don't have an Account? ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Register",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                           recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
