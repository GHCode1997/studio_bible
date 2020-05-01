
class Versiculo {

  int id;
  String text;
  int number;
  String cap;
  String libro;
  int itemId;

  Versiculo({this.id,this.libro,this.cap,this.number,this.text});
  
  factory Versiculo.fromJSON(Map versiculo){
    return new Versiculo(
      id: versiculo['id'],
      libro: versiculo['libro'],
      cap: versiculo['cap'],
      number: versiculo['number'],
      text: versiculo['txt']
    );
  }

  Map toMap(){
    return {
      'id': id,
      'libro': libro,
      'cap': cap,
      'number': number,
      'txt': text
    };
  }
}
// @GenBean()
// class VersiculoBean extends Bean<Versiculo> with _VersiculoBean {
//   ItemBean _itemBean;

//   ItemBean get itemBean => _itemBean ??= new ItemBean(adapter);

//   VersiculoBean(Adapter adapter) : super(adapter);

//   final String tableName = 'items';
// }