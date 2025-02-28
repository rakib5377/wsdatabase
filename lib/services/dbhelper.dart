import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  //singleton
  DBhelper._instance();

  static final DBhelper getInstance = DBhelper._instance();
  Database? myDB;
  static final table_note = 'note';
  static final table_note_sno = 'sno';
  static final table_note_title = 'title';
  static final table_note_desc = 'desc';

  //db open
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
    /*if(myDB != null){
      return myDB!;
    }else{
      myDB =await openDB();
      return myDB!;
    }*/
  }
  // db create
  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "NoteDB.db");
    return await openDatabase(dbPath,version: 1, onCreate: (db, version){
      db.execute('''
        create table $table_note(
        $table_note_sno integer primary key autoincrement,
        $table_note_title text,
        $table_note_desc text
        )
      ''');
    });
  }

  //insert
  Future<bool> insertNote({required String mTitle, required String mDesc}) async{
    var db = await getDB();
    int rowsEffected =await db.insert(table_note, {
      table_note_title : mTitle,
      table_note_desc : mDesc
    });
    return rowsEffected>0;
  }
  // get notes
  Future<List<Map<String, dynamic>>> getAllNotes() async{
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(table_note);
    return mData;
  }

  //update
  Future<bool> updateNote({required String mTitle, required String mDesc, required int id}) async {
    var db = await getDB();
    int rowsEffected = await db.update(table_note, {
      table_note_title: mTitle,
      table_note_desc : mDesc
    },where: "$table_note_sno = ?", whereArgs: [id]);
    return rowsEffected>0;
  }

  // delete
  Future<bool> deleteNote({required int id}) async{
    var db = await getDB();
    int rowsEffected = await db.delete(table_note, where: "$table_note_sno = ?", whereArgs: [id]);
    return rowsEffected> 0;
  }

}