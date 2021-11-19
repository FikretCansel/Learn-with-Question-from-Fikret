import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorularlaogren/data/dbHelper.dart';
import 'package:sorularlaogren/models/question.dart';

class QuestionDetail extends StatefulWidget{
  Question question;
  QuestionDetail(this.question);
  @override
  State<StatefulWidget> createState() {
    return _QuestionDetail(this.question);
  }

}
enum Options { delete }
class _QuestionDetail extends State {
  TextEditingController txtQuestion=new TextEditingController();
  TextEditingController txtA=new TextEditingController();
  TextEditingController txtB=new TextEditingController();
  TextEditingController txtC=new TextEditingController();
  TextEditingController txtD=new TextEditingController();
  TextEditingController txtAnswer=new TextEditingController();
  Question question;
  _QuestionDetail(this.question);

  @override
  void initState() {
    // TODO: implement initState
    txtQuestion.text=question.question;
    txtA.text=question.a;
    txtB.text=question.b;
    txtC.text=question.c;
    txtD.text=question.d;
    txtAnswer.text=question.answer;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Detaylar"),
          actions: <Widget>[
            PopupMenuButton<Options>(
                onSelected: selectProcess,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
                  PopupMenuItem<Options>(
                    value: Options.delete,
                    child: Text("Sil"),
                  ),
                ])
          ],

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
  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await DbHelper().delete(question.id);
        Navigator.pop(context, true);
        break;
      default:
    }
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
        child: Text("Güncelle"),
        onPressed: () async {
          var result =await DbHelper().update(Question.withId(question.id,txtQuestion.text,txtA.text,txtB.text,txtC.text,txtD.text,txtAnswer.text));
          Navigator.pop(context,true);
        });

    }
  }