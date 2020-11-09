import 'package:flutter/material.dart';
import 'package:learnquestions/screens/gameScreen.dart';
import 'package:learnquestions/screens/questionsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn with Question from Fikret',
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
      body:  Column(children: <Widget>[
        buildSizedBox(),
        Text("Learn with Question from Fikret :)",style:TextStyle(color: Colors.white,fontSize: 20),),
        buildSizedBox(),
        Row(children:<Widget> [
        Flexible(
        fit: FlexFit.tight,
        flex: 1,
          child: RaisedButton(
              child: Text("Start",style: TextStyle(color: Colors.white)),
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white)
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GameScreen()));
              },
            ),
          ),
        ],),
        Row(children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: RaisedButton(
              child: Text("Quations",style: TextStyle(color: Colors.white)),
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white)
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionScreen()));
              },
            ),
          ),
        ],)


      ],)
    );
  }

  Widget buildSizedBox() {
    return SizedBox(
      child: Center(
        child: Text("", style: TextStyle(color: Colors.white,fontSize: 20),),
      ),
      width: 100,
      height: 125,
    );
  }
}

