import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnquestions/data/dbHelper.dart';
import 'package:learnquestions/models/question.dart';

class GameScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameScreen();
  }
}

class _GameScreen extends State {
  List<Question> questions=[
    Question("Soru Yok", "", "", "", "", "")
  ];
  int allQuestionsCount=0;
  int selectQuestionCount = 0;
  var aColor=Colors.green;
  var bColor=Colors.green;
  var cColor=Colors.green;
  var dColor=Colors.green;
  bool isAnswed=false;
  int scor=0;
  @override
  void initState() {
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.green,
          body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                    ),

                    Center(
                      child: Text(questions[selectQuestionCount].question,
                        style: TextStyle(color: Colors.white, fontSize: 20),),
                    ),
                    buildAoption(),
                    buildBoption(),
                    buildCoption(),
                    buildDoption(),
                    writeScor(),
                    buildNextButton(),
                  ]
              )
          )
      );
  }
  void getQuestions() {
    var productsFuture = DbHelper().getProducts();
    productsFuture.then((data) {
      if(data.length!=0){
        setState(() {
          this.questions = data;
          allQuestionsCount = data.length;
        });
      }
    });
  }


  Widget buildAoption() {
    return
      Visibility(
        visible: visibilityControl(questions[selectQuestionCount].a),
        child: Row(children:<Widget> [
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                  child: Text(questions[selectQuestionCount].a),
                  color: aColor,
                  onPressed: (){
                    if(!isAnswed){
                      setState(() {
                        aColor=AnswerControl("A");
                      });
                    }
                    isAnswed=true;
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)
                  )
              )
          )])
      );

  }
  Widget buildBoption() {
    return Visibility(
        visible: visibilityControl(questions[selectQuestionCount].b),
    child:Row(children:<Widget> [
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: RaisedButton(
              child: Text(questions[selectQuestionCount].b),
              color: bColor,
              onPressed: (){
                if(!isAnswed){
                  setState(() {
                    bColor=AnswerControl("B");
                  });
                }

                isAnswed=true;
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white)
              )
          )
      )]));

  }
  Widget buildCoption() {
    return Visibility(
        visible: visibilityControl(questions[selectQuestionCount].c),
    child:Row(children:<Widget> [
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: RaisedButton(
              child: Text(questions[selectQuestionCount].c),
              color: cColor,
              onPressed: (){
                if(!isAnswed){
                  setState(() {
                    cColor=AnswerControl("C");
                  });
                }
                isAnswed=true;
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white)
              )
          )
      )]));

  }
  Widget buildDoption() {
    return Visibility(
        visible: visibilityControl(questions[selectQuestionCount].d),
    child:Row(children:<Widget> [
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: RaisedButton(
              child: Text(questions[selectQuestionCount].d),
              color: dColor,
              onPressed: (){
                if(!isAnswed){
                  setState(() {
                    dColor=AnswerControl("D");
                  });
                }
                isAnswed=true;
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white)
              )
          )
      )]));

  }
  buildNextButton() {
    return Visibility(
      visible: isAnswed,
        child: RaisedButton(
        child: Text("Next"),
        color: Colors.blue,
        onPressed: (){
          Random random = new Random();
          selectQuestionCount = random.nextInt(allQuestionsCount);
          setState(() {
            questions;
            aColor=Colors.green;
            bColor=Colors.green;
            cColor=Colors.green;
            dColor=Colors.green;
            scor;
          });
          isAnswed=false;
        }));
  }

   AnswerControl(String idOption) {
    if(idOption==questions[selectQuestionCount].answer){
      scor++;
      return Colors.blue;
    }
    else return Colors.red;
  }

  Widget writeScor() {
    return Text("MyScor : "+scor.toString());
  }

  bool visibilityControl(String option) {
    if(option!=""){
      return true;
    }
    return false;
  }
}