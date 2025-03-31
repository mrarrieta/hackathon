
import 'package:floor/floor.dart';
import 'package:home/data/record.dart';
import 'package:home/data/record_dao.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Record])
abstract class AppDatabase extends FloorDatabase {
  RecordDao get recordDao;
}
