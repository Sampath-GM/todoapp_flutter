  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:http/http.dart' as http;
  import 'package:jwt_decoder/jwt_decoder.dart';
  import 'package:todoapp/constants/url.dart';
  class Homepage extends StatefulWidget {
    final token;

    
    Homepage({@required this.token,Key? key}) : super(key:key);

    @override
    State<Homepage> createState() => _HomepageState();
  }

  class _HomepageState extends State<Homepage> {
    late String userId;
    TextEditingController _textController = TextEditingController();

    @override
    
    void initState(){
      super.initState();
      Map<String,dynamic> JwtDecoderToken = JwtDecoder.decode(widget.token);

      userId = JwtDecoderToken['_id'];

    }
    
    void addTodo() async{
      if(_textController.text.isNotEmpty){
        var reqBody = {
          "userId":userId,
          "title":_textController.text
        };
      

      var response = await http.post(Uri.parse("http://192.168.54.202:3009/user/todo"),
        headers: {"Content-Type":"application/json"},
        body: jsonEncode(reqBody)
      );

      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status']){
        _textController.clear();
        // Navigator.pop(context);
      }
      else{
        print("someting went wrong");
      }
      }
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