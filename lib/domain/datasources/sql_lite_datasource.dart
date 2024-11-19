

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_app/domain/entities/empleado.dart';

class DatabaseHelper {
  static Database? _database;

  // Obtener la base de datos
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Inicializar la base de datos
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'empleados.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Crear la tabla de empleados
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE empleados(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        apellido TEXT NOT NULL,
        cedula TEXT NOT NULL,
        firma TEXT NOT NULL,
        area TEXT NOT NULL,
        cargo TEXT NOT NULL
      )
    ''');
  }

  // Insertar un empleado en la base de datos
  Future<int> insertEmpleado(Empleado empleado) async {
    final db = await database;
    return await db.insert('empleados', empleado.toMap());
  }

  // Insertar una lista de empleados en la base de datos
  Future<void> insertEmpleados(List<Empleado> empleados) async {
    final db = await database;
    // Usamos batch para insertar múltiples empleados
    Batch batch = db.batch();
    for (var empleado in empleados) {
      batch.insert('empleados', empleado.toMap());
    }
    await batch.commit();
  }

  // Obtener todos los empleados
  Future<List<Empleado>> getEmpleados() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('empleados');
    return List.generate(maps.length, (i) {
      return Empleado.fromMap(maps[i]);
    });
  }

  // Obtener un empleado por su ID
  Future<Empleado?> getEmpleadoById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'empleados',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Empleado.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
