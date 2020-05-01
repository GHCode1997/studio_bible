
import 'package:sqflite/sqflite.dart';
import 'package:studio_bible/model/category.dart';
import 'package:studio_bible/providers/item.provider.dart';
import 'package:studio_bible/providers/versiculo.provider.dart';
import 'package:studio_bible/services/locator.service.dart';

/// Esta clase contiene el crud de la clase  categoria
class CategoryProvider {
  Future<Database> data;

  CategoryProvider(Future<Database> data){
    this.data = data;
  }

  Future<List<Categoria>> categories() async {
    // Obtiene una referencia de la base de datos
    final Database db = await data;

    // Consulta la tabla por todos las categorias.
    final List<Map<String, dynamic>> maps = await db.query('category');

    // Convierte List<Map<String, dynamic>> en List<Categoria>.
    return List.generate(maps.length, (i) {
      return Categoria.fromJSON(maps[i]);
    });
  }

  Future<void> insertCategory(Categoria category) async {
    //Se obtiene la referencia de la base de datos
    final Database db = await data;

    await db.insert('category', category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateCategory(Categoria categoria) async {
    // Obtiene una referencia de la base de datos
    final db = await data;

    // Actualiza el Category dado
    await db.update(
      'category',
      categoria.toMap(),
      // Aseguúrate de que solo actualizarás la categoria con el id coincidente
      where: "id = ?",
      // Pasa el id Category a través de whereArg para prevenir SQL injection
      whereArgs: [categoria.id],
    );
  }

  Future<void> deleteCategory(int id) async {
    // Obtiene una referencia de la base de datos
    final db = await data;

    // Elimina el Category de la base de datos
    await locator<ItemProvider>().itemsByCategory(id)
    .then((value){
      if(value != null){
        value.forEach((element) async {
          await locator<VersiculoProvider>().deleteVersiculoByItem(element.id);
        });
      }
    });
    await locator<ItemProvider>().deleteItemByCategory(id);
    await db.delete(
      'category',
      // Utiliza la cláusula `where` para eliminar un categoria específico
      where: "id = ?",
      // Pasa el id Category a través de whereArg para prevenir SQL injection
      whereArgs: [id],
    );
  }
}
