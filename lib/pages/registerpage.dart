import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/constants/url.dart';
import 'package:todoapp/pages/loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userediter = TextEditingController();
  final TextEditingController emailediter = TextEditingController();
  final TextEditingController passwordediter = TextEditingController();

  bool _isNotValidate = false;

  void registerUser() async {
    try{
    if (emailediter.text.isNotEmpty && passwordediter.text.isNotEmpty) {
      var reqBody = {
        "email": emailediter.text,
        "password": passwordediter.text
      };

      var response = await http.post(
        Uri.parse("http://192.168.151.216:3009/user/registration"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print("SomeThing went Wrong");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
    }
    catch(Error){
      print(Error);
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
                  'assets/images/Signup.png',
                  height: 250,
                  width: 250,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 10.0, top: 20.0),
                  child: TextField(
                    controller: userediter,
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      errorText: _isNotValidate ? "Please Enter username" : null,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
                  child: TextField(
                    controller: emailediter,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      errorText: _isNotValidate ? "Please Enter email" : null,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
                  child: TextField(
                    controller: passwordediter,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      errorText: _isNotValidate ? "Please Enter password" : null,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    registerUser();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                    
                  ),
                  child: Container(
                    width: 230,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an Account? ",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Signin",
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
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
