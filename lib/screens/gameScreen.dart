import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorularlaogren/data/dbHelper.dart';
import 'package:sorularlaogren/models/Score.dart';
import 'package:sorularlaogren/models/question.dart';
import 'package:sorularlaogren/screens/answeredAllQuestions.dart';
import 'package:sorularlaogren/services/advert-service.dart';
import '../main.dart';


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
  Score score=Score();
  int selectQuestionCount = 0;
  var aColor=Colors.green;
  var bColor=Colors.green;
  var cColor=Colors.green;
  var dColor=Colors.green;
  bool isAnswer=false;
  final AdvertService adverts=AdvertService();

  @override
  void initState() {
    adverts.showBanner();
    getQuestions();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.green,
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                    children: [

                      returnHomeMenu(),
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
            ),
          )
      );
  }

  void getQuestions() {
    var productsFuture = DbHelper().getProducts();
    productsFuture.then((data) {
      if(data.length!=0){
        setState(() {
          this.questions = data;
          score.questionCount=data.length;
        });
      }
    });
  }
  void showAlertDialog(){
     var alert = AlertDialog(
      title: Text("ilerleme silinecek."),
      content: Text("Ana menüye dönmek istediginize emin misiniz?"),
       actions: [
     TextButton(
      child: Text('Çık'),
         onPressed: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
     ),
         TextButton(
             child: Text('Kal'),
             onPressed: () {
              Navigator.pop(context);
             }
         )
       ],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }


  Widget returnHomeMenu(){
    return Container(
      alignment: FractionalOffset.center,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 100,
            height: 100,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,),
              onPressed: ()=>{
                showAlertDialog()
              }, child: IconButton(icon: Icon(Icons.home),))
        ],
      ),
    );
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
                    if(!isAnswer){
                      setState(() {
                        aColor=answerControl("A");
                      });
                    }
                    isAnswer=true;
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
                if(!isAnswer){
                  setState(() {
                    bColor=answerControl("B");
                  });
                }

                isAnswer=true;
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
                if(!isAnswer){
                  setState(() {
                    cColor=answerControl("C");
                  });
                }
                isAnswer=true;
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
                if(!isAnswer){
                  setState(() {
                    dColor=answerControl("D");
                  });
                }
                isAnswer=true;
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
      visible: isAnswer,
        child: RaisedButton(
        child: Text("Next"),
        color: Colors.blue,
        onPressed: (){
          if(questions.length<=1){

              Navigator.push(context, MaterialPageRoute(builder: (context) => AnsweredAllQuestions(score)));
          }
          else {
            questions.removeAt(selectQuestionCount);
            Random random = new Random();
            selectQuestionCount = random.nextInt(questions.length);
            setState(() {
              aColor = Colors.green;
              bColor = Colors.green;
              cColor = Colors.green;
              dColor = Colors.green;
            });
            isAnswer = false;
          }
        }));
  }

   answerControl(String idOption) {
    if(idOption==questions[selectQuestionCount].answer){
      score.trueAnswerCount++;
      return Colors.blue;
    }
    else
      score.falseAnswers.add(questions[selectQuestionCount]);
      return Colors.red;
  }

  Widget writeScor() {
    return Text("MyScor : "+score.trueAnswerCount.toString());
  }

  bool visibilityControl(String option) {
    if(option!=""){
      return true;
    }
    return false;
  }
  void goToAnsweredAllQuestions(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AnsweredAllQuestions(score)));
  }



}