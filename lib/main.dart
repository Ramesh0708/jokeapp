import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JokeApp(),
    );
  }
}

class JokeApp extends StatefulWidget {
  @override
  _JokeAppState createState() => _JokeAppState();
}

class _JokeAppState extends State<JokeApp> {
  //performing the http request
  String url = "https://official-joke-api.appspot.com/jokes/programming/random";
  String setup = "";
  String punchline = "";
  String type = "";
  Future<String> getData() async {
    Response res = await get(url, headers: {"Accept": "application/json"});
    var data = jsonDecode(res.body);
    print(data[0]['setup']);
    print(data[0]['punchline']);
    setState(() {
      setup = data[0]['setup'];
      punchline = data[0]['punchline'];
      type = data[0]['type'];
    });
    print(res.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${type} Jokes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Card(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "- ${setup}",
                        style: TextStyle(
                          fontSize: 26.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "- ${punchline}",
                        style: TextStyle(
                          fontSize: 26.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () {
                getData();
              },
              color: Color(0xFFFAFAFA),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Text("Another Joke"),
              ),
            )
          ],
        ),
      ),
    );
  }
}