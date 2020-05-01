import 'dart:io';
import 'package:path_provider/path_provider.dart';
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  print(directory.path);
  return directory.path;
}
Future<File> get _localFile async {
  final path = await _localPath;
  return File('assets/xml/BibliaRVR1960.xml');
}
Future<String> readCounter() async {
  try {
    final file = await _localFile;

    // Leer el archivo
    String contents = await file.readAsString();

    return contents;
  } catch (e) {
    // Si encuentras un error
    return "No se leyo";
  }
}
