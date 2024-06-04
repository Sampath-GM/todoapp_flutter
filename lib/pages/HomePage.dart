import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class Homepage extends StatefulWidget {
  final token;
  
  const Homepage({@required this.token,Key? key}) : super(key:key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _textController = TextEditingController();
  @override

  void addTodo() async{
    if(_textController.text.isNotEmpty){
      var resBody = {
        "title":_textController.text
      };
    }

    var response = await http.post(Uri.parse('ApiEndpoints.todo'));
        }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu,color: Colors.white,),
          backgroundColor: Colors.purple,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  suffixIcon:  IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    addTodo();
                  },
                ),
                  hintText: "Enter a Task....",
                  labelText: "Enter a Task",
                ),
              ),
            ),
          ],
        ), 
      );
    
  }
}