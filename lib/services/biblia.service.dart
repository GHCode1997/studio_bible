import 'package:http/http.dart';

class BibliaService {
    String urlBase = "https://backend-studio.herokuapp.com/api.bible.php?key=aldeacms&format=json";

    Future<Response> getBible(){
      return get(urlBase+"&fn=books");
    }
    //https://backend-studio.herokuapp.com/api.bible.php?key=aldeacms&format=json&fn=book&book=salmos&chapter=3
    Future<Response> getLibroVerses(String libro, String chapter) {
      return get(urlBase+"&fn=book&book="+libro+"&chapter="+chapter);
    }
}