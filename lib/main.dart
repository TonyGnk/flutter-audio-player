import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Head.dart';
import 'content.dart';

void main() {
  //appbar icons to dark
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
    statusBarIconBrightness: Brightness.dark, // status bar icons' color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 246, 246),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 38, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Head(),
                  SizedBox(height: 20),
                  Expanded(child: Content()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
