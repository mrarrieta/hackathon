import 'dart:core';

import 'package:floor/floor.dart';
import 'package:home/data/record.dart';

@dao
abstract class RecordDao{

  //on changes run: flutter packages pub run build_runner build --delete-conflicting-outputs

  @Query('SELECT * FROM Record WHERE referenceId = 1 OR referenceId IS NULL ORDER BY time DESC')
  Future<List<Record>> findAllRecords();

  @Query('SELECT * FROM Record WHERE referenceId = :parentId ORDER BY time DESC')
  Future<List<Record>> findAllRecordsByParent(String parentId);

  @insert
  Future<void> insertRecord(Record record);

  @update
  Future<void> updateRecord(Record record);

  @delete
  Future<void> deleteRecord(Record record);
}