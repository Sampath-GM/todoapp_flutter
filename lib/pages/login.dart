import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/Login.png',
                height: 400,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0)))
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0)))
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child:   ElevatedButton(
                onPressed: (){},
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 191, 77, 211)),
                ), 
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  )),
                height: 40,
                width: 250,
              ),
                SizedBox(height: 10,),
                  //forgot password
              InkWell(
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
               
                  ),
                ),
              ),
              
            ],
          )
          ),
          ),
          
    
    );
  }
}