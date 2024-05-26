import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todoapp/pages/HomePage.dart';
import 'package:http/http.dart' as http;

class Loginpage extends StatefulWidget {
   const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailediter = TextEditingController();
  final TextEditingController passwordediter = TextEditingController();

  bool _isNotValidate = false;

  
  @override
  Widget build(BuildContext context) {

    return  Scaffold( 
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
                  height: 400,
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailediter,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0))),
                          errorText: _isNotValidate?"Please Enter email":null
                    ),
                  ),
                ),
               Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordediter,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0))),
                          errorText: _isNotValidate?"Please Enter password":null
                    ),
                    
                  ),
                ),
               const SizedBox(height: 20,),
        
                     ElevatedButton(onPressed: (){
                      // registerUser();  
                     },
                     style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[300]
                     ), 
                    
                    child: const Text("Login",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )),
                  

                 const SizedBox(height: 10,),
                    //forgot password
               const InkWell(
                  child: Text(
                    "Don't have an Account?Register",
                    style: TextStyle(
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