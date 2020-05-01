import 'package:flutter/material.dart';
import 'package:studio_bible/model/Item.dart';


///Esta clase es la categoria 
class Categoria {
  

  int id;
  String nombre;
  String descripcion;
  Color color;
  List<Item> items  ;
  Categoria({this.id,this.nombre, this.descripcion, this.color, this.items});
  Categoria.make(this.id,this.nombre,this.descripcion,this.color,this.items);

  //Convierte el json de categoria en un objeto en dart de la clase categoria
  factory Categoria.fromJSON(Map categoria){
    return new Categoria(id:categoria['id'],nombre:categoria['nombre'], descripcion: categoria['descripcion'],items: categoria['items'],color: Color(categoria['color']),);
  }
  //Retorna el objeto dart de la clase de categoria en JSON
  Map<String,dynamic> toMap(){
    return {
      "nombre": nombre,
      "descripcion": descripcion,
      "color": color.value.abs()
    };
  }
}
// @GenBean()
// class CategoriaBean extends Bean<Categoria> with _CategoriaBean {
//   CategoriaBean(Adapter adapter)
//       : itemBean = ItemBean(adapter), versiculoBean = VersiculoBean(adapter)
//         ,super(adapter);

//   final ItemBean itemBean;

//   final VersiculoBean versiculoBean;

//   Future<int> updateReadField(int id, bool read) async {
//     Update st = updater.where(this.id.eq(id)).set(this.nombre, read);
//     return adapter.update(st);
//   }

//   final String tableName = 'category';
// }