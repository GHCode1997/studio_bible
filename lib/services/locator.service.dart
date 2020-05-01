import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studio_bible/providers/category.provider.dart';
import 'package:studio_bible/providers/item.provider.dart';
import 'package:studio_bible/providers/versiculo.provider.dart';
import 'package:studio_bible/services/biblia.service.dart';

GetIt locator = GetIt.instance;
void setupLocator() async{
  String name = 'bible_studio6_database.db';
  Future<Database> database =  openDatabase(
      // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
      // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
      // construida para cada plataforma.
      join(await getDatabasesPath(), name),
      // Cuando la base de datos se crea por primera vez, crea una tabla para almacenar todo el modelo
      onCreate: (db, version) {

        db.execute(
          "CREATE TABLE category ( id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, descripcion TEXT, color INTEGER);",
        );
        db.execute(
          "CREATE TABLE item (" +
              "id INTEGER PRIMARY KEY AUTOINCREMENT," +
              "comment TEXT," +
              "reference TEXT," +
              "category_id INTEGER" +
              ", FOREIGN KEY(category_id) REFERENCES category(id))",
        );
        db.execute(
          "CREATE TABLE versiculo("+
            "id INTEGER PRIMARY KEY AUTOINCREMENT," + 
            "libro TEXT,"+ 
            "cap TEXT,"+
            "number INTEGER"+
            "txt TEXT" 
            "item_id INTEGER"+
            ", FOREIGN KEY(item_id) REFERENCES item(id))",
        );
      },
      // Establece la versión. Esto ejecuta la función onCreate y proporciona una
      // ruta para realizar actualizaciones y defradaciones en la base de datos.
      version: 1,
    );
  locator.registerSingleton<CategoryProvider>(CategoryProvider(database));
  locator.registerSingleton<ItemProvider>(ItemProvider(database));
  locator.registerSingleton<VersiculoProvider>(VersiculoProvider(database));
  locator.registerLazySingleton<BibliaService>(() => BibliaService());
}

 