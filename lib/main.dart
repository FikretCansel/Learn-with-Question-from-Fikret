import 'package:flutter/material.dart';
import 'package:sorularlaogren/screens/gameScreen.dart';
import 'package:sorularlaogren/screens/questionsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorularla Ogren',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.green,
        body: Column(children: <Widget>[
          SizedBox(
            height: 150,
          ),
          Text("Sorularla Ogren", style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.w900),),
          SizedBox(
            height: 50,
          ),
          Row(children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                child: Text("Başla", style: TextStyle(color: Colors.white)),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GameScreen()));
                },
              ),
            ),
          ],),
          Row(children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: RaisedButton(
                child: Text("Sorular", style: TextStyle(color: Colors.white)),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => QuestionScreen()));
                },
              ),
            ),
          ],)
        ],)
    );
  }
}

