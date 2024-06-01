import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  final token;
  const Homepage({@required this.token,Key? key}) : super(key:key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("ToDo App",style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.purple,
      
      ),
      
      body: SafeArea(
        child:Center(
          child:Image.asset('assets/images/todoapp.png',height: 700,),
        // child: Padding(
        //   padding: EdgeInsets.all(4.0))),
        )
      
      // body: 
    ),
    );
  }
}