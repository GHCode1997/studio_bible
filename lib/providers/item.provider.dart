
import 'package:sqflite/sqflite.dart';
import 'package:studio_bible/model/item.dart';

class ItemProvider {
  Future<Database> database;

  ItemProvider(this.database);
  

  Future<List<Item>> itemsByCategory(int categoryid) async {
    
    // Obtiene una referencia de la base de datos
    final Database db = await database;
    List<Map<String, dynamic>> maps;
    // Consulta la tabla por todos los items by categoria.
    if (db.isOpen) {
      List<Map<String, dynamic>> m = await db.query('item');
      if (!m.isEmpty) {
        maps = await db.query(
          'item',
          where: 'category_id = ?',
          whereArgs: [categoryid],
        );
      }
    }
    // Convierte List<Map<String, dynamic>> en List<Item>.
    if(maps != null){
      return List.generate(maps.length, (i) {
      return Item.fromJSON(maps[i]);
    });
    }else {
      return  null;
    }
  }

  Future<void> insertCategory(Item category) async {
    //Se obtiene la referencia de la base de datos
    final Database db = await database;

    await db.insert('item', category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateCategory(Item item) async {
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Actualiza el Item dado
    await db.update(
      'item',
      item.toMap(),
      // Aseguúrate de que solo actualizarás la item con el id coincidente
      where: "id = ?",
      // Pasa el id Category a través de whereArg para prevenir SQL injection
      whereArgs: [item.id],
    );
  }

  Future<void> deleteItem(int id) async {
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Elimina el Item de la base de datos
    await db.delete(
      'item',
      // Utiliza la cláusula `where` para eliminar un item específico
      where: "id = ?",
      // Pasa el id Item a través de whereArg para prevenir SQL injection
      whereArgs: [id],
    );
  }

  Future<void> deleteItemByCategory(int categoryId) async {
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Elimina el Item de la base de datos
    await db.delete(
      'item',
      // Utiliza la cláusula `where` para eliminar un item específico
      where: "category_id = ?",
      // Pasa el categoryId Item a través de whereArg para prevenir SQL injection
      whereArgs: [categoryId],
    );
  }
}
