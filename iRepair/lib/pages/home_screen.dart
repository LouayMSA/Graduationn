import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:irepair/pages/home.dart';
import 'package:irepair/pages/SplashScreen.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http ;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> _ListKey = GlobalKey();
  final List<String> _data = [];
  static const String BOT_URL = "127.0.0.1:64223/Nm8L5hU9wV8=/ws";
  TextEditingController queryController = TextEditingController();
  /* var data; */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("iRepair ChatBot"),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ));
            ;
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          AnimatedList(
            key: _ListKey,
            initialItemCount: _data.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return buildItem(_data[index], animation, index);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ColorFiltered(
                colorFilter: const ColorFilter.linearToSrgbGamma(),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.message,
                          color: Colors.blue,
                        ),
                        hintText: "Hello!",
                        fillColor: Colors.white12,
                      ),
                      controller: queryController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (msg) {
                        this.getResponse();
                      },
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  void getResponse() {
    if (queryController.text.isNotEmpty) {
      this.insertSingleItem(queryController.text);
      var client = getClient();
      try{
        client.post(
          BOT_URL,
          body:{"query" : queryController.text},
        ). then((response)
        {
          print(response.body);
          Map<String, dynamic> data
          = jsonDecode(response.body);
          insertSingleItem(data['response']+"<bot>");
        }
        );
      }
      finally{
        client.close();
        queryController.clear();
      }
    }
  }

  void insertSingleItem(String message) {
    _data.add(message);
    _ListKey.currentState?.insertItem(_data.length - 1);
  }

  //get client
  http.Client getClient(){
    return http.Client();
  }
}

Widget buildItem(String item, Animation<double> animation, int index) {
  bool mine = item.endsWith("<bot>");
  return SizeTransition(
    sizeFactor: animation,
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        alignment: mine ? Alignment.topLeft : Alignment.topRight,
        child: Bubble(
          color: mine ? Colors.blue : Colors.grey[200],
          padding: BubbleEdges.all(10),
          child: Text(
            item.replaceAll("<bot>", ""),
            style: TextStyle(color: mine ? Colors.white : Colors.black),
          ),
        ),
      ),
    ),
  );
}
