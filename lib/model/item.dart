import 'package:studio_bible/model/versiculo.dart';
class Item {

  int id;

  String comment;
  List<Versiculo> verses;
  String reference;
  int categoriaId;

  Item({this.id,this.comment,this.verses,this.reference}){
    int index = 0;
    verses.forEach((element,) {
      if(index == 0){
        this.reference = element.libro.toUpperCase()+' '+element.number.toString()+':';
      } else if(index == verses.length-1){
        this.reference += element.number.toString();
      }
      index++;
     });
  }
  Item.make(this.id, this.comment,this.verses){
    int index = 0;
    verses.forEach((element,) {
      if(index == 0){
        this.reference = element.libro.toUpperCase()+' '+element.number.toString()+':';
      } else if(index == verses.length-1){
        this.reference += element.number.toString();
      }
      index++;
     });
  }

  factory Item.fromJSON(Map item){
    return new Item(
      id: item['id'],
      comment: item['comment'],
      reference: item['reference']
    );
  }

  Map toMap(){
    return {
      'id': id,
      'comment': comment,
      'reference': reference
    } ;
  }

}
// @GenBean()
// class ItemBean extends Bean<Item> with _ItemBean {
//   CategoriaBean _categoriaBean;

//   CategoriaBean get categoriaBean => _categoriaBean ??= new CategoriaBean(adapter);

//   ItemBean(Adapter adapter) : super(adapter);

//   final String tableName = 'items';
// }