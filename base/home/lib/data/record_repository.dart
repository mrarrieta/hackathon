
import 'dart:async';

import 'package:home/data/database.dart';
import 'package:home/data/record.dart';
import 'package:ui/tools/date_tools.dart';

class RecordRepository {
  RecordRepository(this.dateTools);

  final DateTools dateTools;
  
  late AppDatabase _database;
  
  bool _isInitialized = false;

  Future<AppDatabase> getDatabase(){
    if(_isInitialized) {
      return Future.value(_database);
    } else {
      return init();
    }
  }

  Future<AppDatabase> init() {
    _isInitialized = true;
    return $FloorAppDatabase.databaseBuilder('app_getDatabase().db').build().then((value) {
      _database = value;
      return _database;
    });
  }

  Future closeDb(){
    return getDatabase().then((database) {
      return database.close().then((value) => init());
    });
  }

  Future<void> addRecord(Record record) {
    return getDatabase().then((database) {
      return database.recordDao.insertRecord(record)
          .catchError((error) {
            database.recordDao.updateRecord(record);
          });
    });
  }

  Future<void> removeRecord(Record record) {
    return getDatabase().then((database) {
      return database.recordDao.deleteRecord(record);
    });
  }

  Future<List<Record>> getRecordsByParent(String parentId) {
    return getDatabase().then((database) {
      return database.recordDao.findAllRecordsByParent(parentId);
    });
  }

  Future<List<Record>> getAllRecords() {
    return getDatabase().then((database) {
      return database.recordDao.findAllRecords();
    });
  }
}