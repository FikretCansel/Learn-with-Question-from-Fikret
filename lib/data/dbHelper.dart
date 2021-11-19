import 'dart:async';
import 'package:sorularlaogren/models/question.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  Database _db;

  Future<Database> get db async{
    if(_db==null){
      _db= await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(),"questions.db");
    var questionDb= await openDatabase(dbPath,version: 1,onCreate: createDb);
    return questionDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(("Create table questions(id integer primary key,question text,a text,b text,c text,d text,answer text)"));
    await insert(Question("İlk evcilleştirilmiş hayvan aşağıdakilerden hangisidir?","koyun","at","eşşek","köpek","D"));
    await insert(Question("Hangisi tarihteki Türk devletlerinden biri değildir?","Avar Kağanlığı","Hun İmparatorluğu","Emevi Devleti","Hazar Devleti","C"));
    await insert(Question("Hangisi bir hücrede bulunan organeldir?","Rna","Dna","Lizozom","Mitokondri","C"));
    await insert(Question("Hangi hayvan memeli değildir?","Penguen","Yarasa","Yunus","köpek","A"));
    await insert(Question("Hangisi kuvvet birimidir?","Pascal","Joule","Newton","","C"));
    await insert(Question("I need a…..of bread","Bottle","Loaf","Can","Coup","B"));
  }
  Future<List<Question>> getProducts() async{
    Database db= await this.db;
    var result = await db.query("questions");
    return List.generate(result.length,(index) {
      return Question.fromObject(result[index]);
    });
    //id:result[index]["id"],name: result[index]["name"]
  }
  Future<int> insert(Question question) async{
    Database db= await this.db;
    var result=await db.insert("questions", question.toMap());
  }
  Future<int> delete(int id) async{
    Database db= await this.db;
    var result=await db.delete("questions",where: "id=?",whereArgs: [id]);
    return result;
  }
  Future<int> update(Question question) async{
    Database db= await this.db;
    var result=await db.update("questions", question.toMap(),where: "id=?",whereArgs: [question.id]);
    return result;
  }
  Future<int> clearAll() async{
    Database db= await this.db;
    var result=await db.delete("questions");
    return result;
  }


}