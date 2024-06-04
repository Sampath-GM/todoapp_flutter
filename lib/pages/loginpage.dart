import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/constants/url.dart';
import 'package:todoapp/pages/HomePage.dart';
import 'package:http/http.dart' as http;

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emailediter = TextEditingController();
  final TextEditingController _passwordediter = TextEditingController();
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
    if (_emailediter.text.isNotEmpty && _passwordediter.text.isNotEmpty) {
      final String url = Uri.parse(ApiEndpoints.login).toString();
      final Map<String, String> reqBody = {
        "email": _emailediter.text,
        "password": _passwordediter.text,
      };

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] as bool) { // Type cast for clarity
          final String myToken = jsonResponse['token'];
          await _preferences.setString('token', myToken);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Homepage(token: myToken)));
        } else {
          setState(() {
            _loginError = "Invalid login credentials."; // Set error message
          });
        }
      } else {
        _isNotValidated = true;
        print("Error: ${response.statusCode}");
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
                  padding: const EdgeInsets.only(left: 30.0,right: 30.0,bottom: 10.0,top: 20.0),
                  child: TextField(
                    controller: _emailediter,
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
                  padding: const EdgeInsets.only(left: 30.0,right: 30.0,bottom: 10.0,top: 20.0),
                  child: TextField(
                    controller: _passwordediter,
                    obscureText: true, // Hide password input
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      errorText: _isNotValidated ? "Please enter your password." : null,
                    ),
                  ),
                ),
                if (_loginError.isNotEmpty) // Conditionally display error text
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
                  ) 
                  //  Text(
                  //   "Login",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //   ),
                  // ),
                ),
                const SizedBox(height: 10),
                 InkWell(
                  child: RichText(
                    text: const TextSpan(
                      text: "Don't have an Account? ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Register",
                          style: TextStyle(
                            color: Colors.blue
                          )
                        )
                      ]
                    ),
                    
                  ),
                ),  
              ],
            )
            ),
        ),
          ),
    );
  }
}

