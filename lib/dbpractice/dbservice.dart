import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbService{
  DbService._instance();
 static final getInstance = DbService._instance();
 Database? testDB;

 static final String TABLE_NOTE = 'note';
 static final String TABLE_NOTE_SNO = 'sno';
 static final String TABLE_NOTE_TITLE = 'title';
 static final String TABLE_NOTE_DESC = 'desc';

 // open db

  Future<Database> openDB() async {
    testDB ??= await createDB();
    return testDB!;
  }
  // create db or open existing one
  Future<Database> createDB() async{
    Directory appDir = await getApplicationDocumentsDirectory();
    String dpPath = join(appDir.path, "testDB.db");
    return await openDatabase(dpPath,version: 1,onCreate: (db, version){
      db.execute('''
        create table $TABLE_NOTE(
        $TABLE_NOTE_SNO integer primary key autoincrement,
        $TABLE_NOTE_TITLE text,
        $TABLE_NOTE_DESC text
        )
      ''');
    });
  }
  //insert
  Future<bool> insertNote({required String mTitle, required String mDesc}) async {
    var db = await openDB();
    int rowsEffected = await db.insert(TABLE_NOTE, {
      TABLE_NOTE_TITLE : mTitle,
      TABLE_NOTE_DESC : mDesc
    });
    return rowsEffected>0;
  }
  //fetch
  Future<List<Map<String, dynamic>>> fetchData() async{
    var db = await openDB();
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE);
    return mData;
  }
  //update
  Future<bool> updateData({required String mTitle, required String mDesc, required int id}) async{
    var db = await openDB();
    int rowsEffected = await db.update(TABLE_NOTE, {
      TABLE_NOTE_TITLE : mTitle,
      TABLE_NOTE_DESC : mDesc
    }, where: "$TABLE_NOTE_SNO = ?", whereArgs: [id]);
    return rowsEffected > 0;
  }
  // delete
  Future<bool> deleteData({required int id}) async{
    var db = await openDB();
    int rowsEffected = await db.delete(TABLE_NOTE, where: "$TABLE_NOTE_SNO = ?", whereArgs: [id]);
    return rowsEffected > 0;
  }

}