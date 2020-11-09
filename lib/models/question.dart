class Question{
  int id;
  String question;
  String a;
  String b;
  String c;
  String d;
  String answer;
  Question(this.question,this.a,this.b,this.c,this.d,this.answer);
  Question.withId(this.id,this.question,this.a,this.b,this.c,this.d,this.answer);
  Map<String,dynamic> toMap(){
  var map=new Map<String,dynamic>();
  map["question"]=this.question;
  map["a"]=this.a;
  map["b"]=this.b;
  map["c"]=this.c;
  map["d"]=this.d;
  map["answer"]=this.answer;
  if(id!=null){
    map["id"]=id;
  }
  return map;
  }
  Question.fromObject(dynamic o){
    this.id=int.tryParse(o["id"].toString());
    this.question=o["question"];
    this.a=o["a"];
    this.b=o["b"];
    this.c=o["c"];
    this.d=o["d"];
    this.answer=o["answer"];
  }
}