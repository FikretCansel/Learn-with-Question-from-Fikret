import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnquestions/data/dbHelper.dart';
import 'package:learnquestions/models/question.dart';
import 'package:learnquestions/screens/questionsScreen.dart';

class QuestionAddScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QuestionAddScreen();
  }

}

class _QuestionAddScreen extends State{
  TextEditingController txtQuestion=new TextEditingController();
  TextEditingController txtA=new TextEditingController();
  TextEditingController txtB=new TextEditingController();
  TextEditingController txtC=new TextEditingController();
  TextEditingController txtD=new TextEditingController();
  TextEditingController txtAnswer=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Question"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
            buildTextQuestion(),
            buildTextA(),
            buildTextB(),
            buildTextC(),
            buildTextD(),
            buildAnswer(),
            buildSaveButton()
      ],
      ),
          ),
        ),
      )

    );
  }

  Widget buildTextQuestion() {
    return TextField(
      decoration: InputDecoration(labelText: "Write question"),
      controller: txtQuestion,
    );
  }

  Widget buildTextA() {
    return TextField(
      decoration: InputDecoration(labelText: "Write A option"),
      controller: txtA,
    );
  }

  Widget buildTextB() {
    return TextField(
      decoration: InputDecoration(labelText: "Write B option"),
      controller: txtB,
    );
  }

  Widget buildTextC() {
    return TextField(
      decoration: InputDecoration(labelText: "Write C option"),
      controller: txtC,
    );
  }

  Widget buildTextD() {
    return TextField(
      decoration: InputDecoration(labelText: "Write D option"),
      controller: txtD,
    );
  }

  Widget buildAnswer() {
    return TextField(
      decoration: InputDecoration(labelText: "Write Answer option"),
      controller: txtAnswer,
    );
  }

  buildSaveButton(){
    return RaisedButton(
      child: Text("Save"),
        onPressed: () async {
          var result =await DbHelper().insert(Question(txtQuestion.text,txtA.text,txtB.text,txtC.text,txtD.text,txtAnswer.text));
          Navigator.pop(context,true);
    });
  }

}