import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorularlaogren/data/dbHelper.dart';
import 'package:sorularlaogren/models/question.dart';
import 'package:sorularlaogren/screens/questionAddScreen.dart';
import 'package:sorularlaogren/screens/questionDetail.dart';

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
  var dbHelper=DbHelper();

  @override
  void initState() {
    getQuestions();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Sorular"),ElevatedButton(onPressed: ()=>{showAlertDialog()}, child: Text("Tümünü Sil"))],),
      ),
      body: Column(children: <Widget>[
        buildQuestionList(),
        buildMenu()
      ],)
    );
  }
  void showAlertDialog(){
    var alert = AlertDialog(
      title: Text("tüm sorular silinecek"),
      content: Text("emin misiniz?"),
      actions: [
        TextButton(
            child: Text('Hayır'),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
        TextButton(
            child: Text('Evet'),
            onPressed: () {
              clearQuestions();
              Navigator.pop(context);
            }
        )
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }


  void clearQuestions(){
    dbHelper.clearAll();
    setState(() {
      allQuestionsCount=0;
    });

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
        child: Text("Ekle"),
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