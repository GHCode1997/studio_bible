
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:selectable_circle/selectable_circle.dart';
import 'package:studio_bible/model/Item.dart';
import 'package:studio_bible/model/category.dart';
import 'package:studio_bible/providers/category.provider.dart';
import 'package:studio_bible/services/locator.service.dart';
class AddCategoryCardView extends StatefulWidget {
  AddCategoryCardView({Key key}): super(key:key);
  _AddCategoryCardViewState createState() => _AddCategoryCardViewState();
}

class _AddCategoryCardViewState extends State<AddCategoryCardView> {
  final TextEditingController _nameCategory = new TextEditingController();
  final TextEditingController _desCategory = new TextEditingController();
  final List<Color> _listColor = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.brown
  ];
  bool selectedColor= false;
  Color colorSelected;
  initState(){
    super.initState();
    this.colorSelected = null;
  }
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 200,
      semanticContainer: true,
      //margin: EdgeInsets.only(bottom: 100,top: 100),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
          child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text(
                'Añadir Categoria',
                style: TextStyle(fontSize: 30,color: Colors.white),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _nameCategory,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.text_fields,color: Colors.white,),
                  labelText: "Nombre",
                  hintText: "Ingrese el nombre de la categoria",
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white60)
                  ),
              style: TextStyle(color: Colors.white),
            ),
            Divider(),
            TextField(
              controller: _desCategory,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.description, color: Colors.white,),
                  labelText: "Descripcion",
                  hintText:
                      "Ingrese una descripcion de la categoria(Opcional)",
                      labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white60)),
              style: TextStyle(color: Colors.white),
              maxLines: 3,
              maxLength: 100,
              cursorWidth: 2,
            ),
            Divider(),
            Row(
              children: <Widget>[Icon(Icons.color_lens,color: Colors.white,), Text('Color',style: TextStyle(color:Colors.white),)],
            ),
            //Lista de color en circulos
            Row(
              children: <Widget>[
                SizedBox(
                  width: 60,
                ),
                SelectableCircle(
                      color: _listColor[0],
                      borderColor: _listColor[0],
                    width: 50.0,
                    onTap: () {
                      setState(() {
                        colorSelected = _listColor[0];
                      });
                    },
                    selectedColor: _listColor[0],
                    selectMode: SelectMode.simple ,
                    isSelected: _listColor[0] == colorSelected,
                    selectedBorderColor: Colors.black,
                  ),
                  SelectableCircle(
                      color: _listColor[1],
                      borderColor: _listColor[1],
                    width: 50.0,
                    onTap: () {
                      setState(() {
                        colorSelected = _listColor[1];
                      });
                    },
                    selectedColor: _listColor[1],
                    selectMode: SelectMode.simple ,
                    isSelected: _listColor[1] == colorSelected,
                    selectedBorderColor: Colors.black,
                  ),
                  SelectableCircle(
                      color: _listColor[2],
                      borderColor: _listColor[2],
                    width: 50.0,
                    onTap: () {
                      setState(() {
                        colorSelected = _listColor[2];
                      });
                    },
                    selectedColor: _listColor[2],
                    selectMode: SelectMode.simple ,
                    isSelected: _listColor[2] == colorSelected,
                    selectedBorderColor: Colors.black,
                  ),
                  SelectableCircle(
                      color: _listColor[3],
                      borderColor: _listColor[3],
                    width: 50.0,
                    onTap: () {
                      setState(() {
                        colorSelected = _listColor[3];
                      });
                    },
                    selectedColor: _listColor[3],
                    selectMode: SelectMode.simple ,
                    isSelected: _listColor[3] == colorSelected,
                    selectedBorderColor: Colors.black,
                  ),
                  SelectableCircle(
                      color: _listColor[4],
                      borderColor: _listColor[4],
                    width: 50.0,
                    onTap: () {
                      setState(() {
                        colorSelected = _listColor[4];
                      });
                    },
                    selectedColor: _listColor[4],
                    selectMode: SelectMode.simple ,
                    isSelected: _listColor[4] == colorSelected,
                    selectedBorderColor: Colors.black,
                  ),
              ],

            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                    animationDuration: Duration(milliseconds: 500),
                    textColor: Colors.white,
                    child: Text('Ok'),
                    onPressed: () {
                      var categoria = new Categoria(
                      nombre: _nameCategory.text,
                      descripcion: " "+_desCategory.text,
                      color: colorSelected,
                      items: List<Item>()
                      );
                      locator<CategoryProvider>().insertCategory(categoria);
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeView(item: "categorias",)),(route)=> false);
                      Navigator.of(context).pop(true);
                    }),
                MaterialButton(
                    highlightColor: Colors.yellow[100],
                    animationDuration: Duration(milliseconds: 500),
                    child: Text('Cancelar',style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    })
              ],
            ),
          ],
        ),
        )
    );
  }
}
