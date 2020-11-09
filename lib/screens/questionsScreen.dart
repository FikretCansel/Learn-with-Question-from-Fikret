import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnquestions/data/dbHelper.dart';
import 'package:learnquestions/models/question.dart';
import 'package:learnquestions/screens/questionAddScreen.dart';
import 'package:learnquestions/screens/questionDetail.dart';

class QuestionScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QuestionScreen();
  }

}

class _QuestionScreen extends State{
  List<Question> questions;
  int allQuestionsCount=0;
  @override
  void initState() {
    getQuestions();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions Screen"),
      ),
      body: Column(children: <Widget>[
        buildQuestionList(),
        buildMenu()
      ],)
    );
  }

  Widget buildQuestionList() {
    return Expanded(
      child: ListView.builder(
          itemCount: allQuestionsCount,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(questions[index].question),
                onTap: () async {
                  bool result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionDetail(questions[index])));
                  if(result!=null){
                    print("notnull");
                    if(result==true){
                      print("true");
                      getQuestions();
                    }
                  }
                }
            );
          }),
    );
  }

  Widget buildMenu() {
    return Row(
      children: <Widget>[
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child:
    RaisedButton(
        color: Colors.green,
        child: Text("Add"),
        onPressed: () async {
          bool result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionAddScreen()));
          if(result!=null){
            if(result==true){
              getQuestions();
            }
          }

        })
      )

      ],
    );
  }

  void getQuestions() {
    var productsFuture=DbHelper().getProducts();
    productsFuture.then((data){
      setState(() {
        this.questions=data;
        allQuestionsCount=data.length;
      });
    });
  }
}