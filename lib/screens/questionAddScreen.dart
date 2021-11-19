import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorularlaogren/data/dbHelper.dart';
import 'package:sorularlaogren/models/question.dart';

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
  TextEditingController txtAnswer=new TextEditingController(text: "A");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Ekle"),
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
              buildAnswerDropDown(),
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
      decoration: InputDecoration(labelText: "Soru"),
      controller: txtQuestion,
    );
  }

  Widget buildTextA() {
    return TextField(
      decoration: InputDecoration(labelText: "A şıkkı"),
      controller: txtA,
    );
  }

  Widget buildTextB() {
    return TextField(
      decoration: InputDecoration(labelText: "B şıkkı"),
      controller: txtB,
    );
  }

  Widget buildTextC() {
    return TextField(
      decoration: InputDecoration(labelText: "C şıkkı"),
      controller: txtC,
    );
  }

  Widget buildTextD() {
    return TextField(
      decoration: InputDecoration(labelText: "D şıkkı"),
      controller: txtD,
    );
  }


    buildAnswerDropDown(){
      return DropdownButton<String>(
        value: txtAnswer.text,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            txtAnswer.text = newValue;
          });
        },
        items: <String>['A', 'B', 'C', 'D']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    }


  buildSaveButton(){
    return ElevatedButton(
      child: Text("Kaydet"),
        onPressed: () async {
          var result =await DbHelper().insert(Question(txtQuestion.text,txtA.text,txtB.text,txtC.text,txtD.text,txtAnswer.text));
          Navigator.pop(context,true);
    });
  }

}