import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorularlaogren/models/Score.dart';
import 'package:sorularlaogren/services/advert-service.dart';

import '../main.dart';

class AnsweredAllQuestions extends StatefulWidget{

  Score score;
  AnsweredAllQuestions(this.score);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState



    return _AnsweredAllQuestions(score);
  }


}
class _AnsweredAllQuestions extends State<AnsweredAllQuestions>{
  final AdvertService advertService=AdvertService();
  Score score;
  _AnsweredAllQuestions(this.score);

  @override
  void initState() {
    // TODO: implement initState
    advertService.showInterstitial();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {





    return Scaffold(
      backgroundColor: Colors.green,
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100,),
            Text("Skorunuz :${this.score.trueAnswerCount.toString()}/${this.score.questionCount.toString()}"),
            ElevatedButton(onPressed: ()=>{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage())),
            }, child: IconButton(icon: Icon(Icons.home),)),
            SizedBox(height: 15,),
            Text("Yanlış Yaptığınız Sorular",style: TextStyle(fontSize: 20),),
            Container(
              height: 600,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: score.falseAnswers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.grey,
                      width: 150,
                      height: 50,
                      child: Center(child: Text(score.falseAnswers[index].question.toString())),
                    );
                  }
              ),
            ),
          ],
        ),
      )
    );
  }

}