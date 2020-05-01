import 'package:flutter/material.dart';
import 'package:studio_bible/model/category.dart';
import 'package:studio_bible/providers/category.provider.dart';
import 'package:studio_bible/services/locator.service.dart';
import 'package:studio_bible/views/addcategoria.view.dart';
import 'package:studio_bible/views/item.view.dart';

///Este es el widget de la vista del tab categorias
///
class CategoriesView extends StatefulWidget {

  CategoriesView({Key key}) : super(key: key);

  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  List<Categoria> _listCategories = List<Categoria>();
  
  initState() {
    super.initState();
    getCategorias();
  }

  getCategorias()async {
    this._listCategories = await locator<CategoryProvider>().categories();
    _listCategories.forEach((element) { 
      print('id: '+element.id.toString());
    });
    setState(() {
      this._listCategories = _listCategories;
    });
    print(_listCategories.length);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: new ListView.builder(

        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _listCategories.length,
        itemBuilder: (BuildContext context, int index) {
          var descripcion = _listCategories[index].descripcion;
          var lenght =descripcion.length;
          return Card(
              elevation: 8.0,
              margin: index != _listCategories.length-1 ? new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0) : new EdgeInsets.only(bottom: 73,left: 10,right: 10,top: 6 ) ,
              child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemView(_listCategories[index])));
                    },
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.white24))),
                        child: InkResponse(
                          onTap: () {
                            print(_listCategories[index].nombre);
                          },
                          child: new Container(
                            width: 30,
                            height: 30,
                            decoration: new BoxDecoration(
                              color: _listCategories[index].color,
                              shape: BoxShape.circle,
                            ),
                            child: PopupMenuButton(
                              icon: Icon(
                                Icons.subtitles,
                                color: Colors.transparent,
                              ),
                              onSelected: (opcion) {},
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                PopupMenuItem<bool>(
                                  value: true,
                                  child: Text('Working a lot harder'),
                                ),
                              ],
                            ),
                          ),
                        )),
                    title: Text(
                      _listCategories[index].nombre,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                    subtitle: Row(
                      children: <Widget>[
                        //Icon(Icons.subtitles, color: Colors.yellowAccent),
                        Text(lenght > 25 ? descripcion.substring(0,25) 
                                          + '\n' + descripcion.substring(25,lenght > 50 ? 50 : lenght-1)  
                                          +  (lenght > 50 ? '\n'+ descripcion.substring(50, lenght>75? 75 : lenght-1): '') 
                                          + (lenght>75? '\n'+descripcion.substring(75,lenght-1) : '') 
                                          : descripcion ,
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String opcion) {
                        if(opcion== 'eliminar'){
                          locator<CategoryProvider>().deleteCategory(_listCategories[index].id);
                          setState(() {
                            getCategorias();
                          });
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'eliminar',
                          child: Text('Eliminar'),
                        ),
                      ],
                    ),
                  )));
        },
      ),
      floatingActionButton: FloatingActionButton( 
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () async {
            print('object');
            final result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddCategoryCardView()));
            if(result){
              setState(() {
                getCategorias();
              });
            }
          }),
    );
  }
}
