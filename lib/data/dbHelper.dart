import 'dart:async';
import 'package:learnquestions/models/question.dart';
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
    String dbPath = join(await getDatabasesPath(),"quess.db");
    var questionDb= await openDatabase(dbPath,version: 1,onCreate: createDb);
    return questionDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(("Create table questions(id integer primary key,question text,a text,b text,c text,d text,answer text)"));
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
}