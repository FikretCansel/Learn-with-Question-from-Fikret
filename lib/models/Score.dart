import 'package:sorularlaogren/models/question.dart';

class Score{
  int questionCount;
  int trueAnswerCount;
  List<Question> falseAnswers;

  Score(){
    questionCount=0;
    falseAnswers=[];
    trueAnswerCount=0;
  }

}