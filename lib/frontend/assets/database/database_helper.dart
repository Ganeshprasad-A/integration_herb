import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDirectory.path, 'need.db');

    if (!await File(dbPath).exists()) {
      ByteData data =
          await rootBundle.load('lib/frontend/assets/database/need.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes);
    }

    return await openDatabase(dbPath);
  }

  Future<Map<String, dynamic>?> fetchHerb(String name) async {
    try {
      final db = await database;
      final result = await db.query(
        'need', // Table name
        where: 'name = ?', // Filtering condition
        whereArgs: [name], // Dynamic argument
      );

      if (result.isNotEmpty) {
        return result.first;
      }
    } catch (e) {
      print('Error fetching herb by name: $e');
    }
    return null;
  }
}
