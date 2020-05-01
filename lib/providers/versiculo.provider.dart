import 'package:sqflite/sqflite.dart';
import 'package:studio_bible/model/versiculo.dart';

class VersiculoProvider {
  Future<Database> database;

  VersiculoProvider(this.database);

  Future<List<Versiculo>> versiculosByItem(int itemid) async {
    // Obtiene una referencia de la base de datos
    final Database db = await database;

    // Consulta la tabla por todos las categorias.
    final List<Map<String, dynamic>> maps = 
    await db.query('item',where: 'item_id = ?',whereArgs: [itemid]);

    // Convierte List<Map<String, dynamic>> en List<Versiculo>.
    return List.generate(maps.length, (i) {
      return Versiculo.fromJSON(maps[i]);
    });
  }

  Future<void> insertVersiculo(Versiculo versiculo) async {
    //Se obtiene la referencia de la base de datos
    final Database db = await database;

    await db.insert('item', versiculo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateVersiculo(Versiculo versiculo) async {
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Actualiza el Versiculo dado
    await db.update(
      'versiculo',
      versiculo.toMap(),
      // Aseguúrate de que solo actualizarás la versiculo con el id coincidente
      where: "id = ?",
      // Pasa el id Versiculo a través de whereArg para prevenir SQL injection
      whereArgs: [versiculo.id],
    );
  }

  Future<void> deleteVersiculo(int id) async {
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Elimina el Versiculo de la base de datos
    await db.delete(
      'versiculo',
      // Utiliza la cláusula `where` para eliminar un versiculo específico
      where: "id = ?",
      // Pasa el id del Versiculo a través de whereArg para prevenir SQL injection
      whereArgs: [id],
    );
  }
  Future<void> deleteVersiculoByItem(int itemId) async {
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Elimina el Versiculo de la base de datos
    await db.delete(
      'versiculo',
      // Utiliza la cláusula `where` para eliminar un versiculo específico
      where: "item_id = ?",
      // Pasa el item_id del Versiculo a través de whereArg para prevenir SQL injection
      whereArgs: [itemId],
    );
  }
}