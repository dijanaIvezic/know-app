import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Base{
  static Base _instance;
  Future<Database> base;
  factory Base(){
    if(_instance == null){
      _instance = Base._private();
    }
    return _instance;
  }
  Base._private(){
    base = create();
  }

  Future<Database> create() async{
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "data.db");

    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("databases", "data.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(path, readOnly: true);
  }
}