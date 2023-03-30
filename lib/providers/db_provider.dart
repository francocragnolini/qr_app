import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // path de donde almacenamos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, 'ScansDB.db');
    log(path);

    // crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute('''
      CREATE TABLE Scans(
        id INTEGER PRIMARY KEY,
        tipo TEXT,
        valor TEXT
      )

    ''');
      },
    );
  }

  //? insertando registros a traves de queries
  // Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
  //   final id = nuevoScan.id;
  //   final tipo = nuevoScan.tipo;
  //   final valor = nuevoScan.valor;

  //   final db = await database;
  //   final res = await db.rawInsert('''
  //   INSERT INTO Scans(id, tipo, valor)
  //     VALUES($id, $tipo, $valor)

  //   ''');

  //   return res;
  // }

  //? utilizando orm el metodo insert
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    // esperando a la db
    final db = await database;

    // insertando los datos
    final res = await db.insert("Scans", nuevoScan.toMap());

    log("$res");
    // ID del ultimo registro insertado
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;

    // buscar en la tabla Scans un registro por id
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromMap(res.first) : null;
  }

  // Signo de interrogacion en esta ubicacion hace nullable la lista
  Future<List<ScanModel>?> getAllScans() async {
    final db = await database;

    // buscar en la tabla Scans un registro por id
    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromMap(scan)).toList()
        : [];
  }

  Future<List<ScanModel>?> getScansPorTipo(String tipo) async {
    final db = await database;

    // buscar en la tabla Scans un registro por id
    final res = await db.rawQuery('''
    SELECT * FROM Scans WHERE tipo = $tipo

    ''');

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromMap(scan)).toList()
        : [];
  }

  // no testeado
  Future<int> updateScan(ScanModel nuevoScan, int id) async {
    final db = await database;
    final res = await db
        .update('Scans', nuevoScan.toMap(), where: 'id = ?', whereArgs: [id]);

    return res;
  }

  // no testeado
  //? borrar un registro de la tabla por id
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: "id=?", whereArgs: [id]);

    return res;
  }

  //? borrar todos los registros de la tabla Scans
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return res;
  }
}
