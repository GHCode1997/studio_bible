import 'package:flutter/material.dart';
import 'package:studio_bible/services/biblia.service.dart';
import 'package:studio_bible/services/locator.service.dart';
import 'package:studio_bible/views/utils/dropdown.dart';
import '../model/category.dart';

class ItemView extends StatefulWidget {
  ItemView(this.categoria, {Key key}) : super(key: key);

  _ItemView createState() => _ItemView();

  final Categoria categoria;
}

class _ItemView extends State<ItemView> {
  List<String> _libros = List<String>();
  List<String> _caps = List<String>();
  List<String> _versiculos = List<String>();
  String selectLibro = "";
  String selectCap = "";
  String selectVer1 = "";
  String selectVer2 = "";
  initState() {
    super.initState();
  }

  setState(fn) {
    super.setState(fn);
  }

  getLibros() {
    locator<BibliaService>().getBible().then((value) {
      print(value);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria.nombre),
      ),
      body: Container(
        child: ListView.builder(
          itemCount:
              widget.categoria.items != null ? widget.categoria.items : 0,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(widget.categoria.items[index].reference),
                    onLongPress: () {},
                  ),
                  Divider()
                ],
              ),
            );
          },
        ),
      ),
      extendBody: true,
      persistentFooterButtons: <Widget>[
        Row(children: <Widget>[
          MaterialButton(
              child: Text('Buscar versiculo'),
              onPressed: () {
                print('Este espacio es para el dialog de buscar versiculo');
                _showFindVerse();
              }),
          SizedBox(
            width: 120,
          )
        ])
      ],
    );
  }

  Future<void> _showFindVerse() {
    String lib;
    setState(() {
      lib = DropdownInput().select;
      print(lib);
    });
    var opc = DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            items: this
                                ._libros
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          );
    var opc2 = DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            items: this
                                ._caps
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          );
    var opc3 = DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            items: this
                                ._versiculos
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          );
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return Card(
              margin: EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  //Es la parte para seleccionar los versiculos
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 19,
                      ),
                      Text('libro: '),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(12),
                          child: opc ,),
                      Container(
                        margin: EdgeInsets.all(12),
                        child: opc2,
                      ),
                      Text(':'),
                      Container(
                        margin: EdgeInsets.all(12),
                        child: opc3,
                      ),
                      Text("-"),
                      Container(
                        margin: EdgeInsets.all(12),
                        child: opc3,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      DropdownButton(
                        value: 'data',
                        items: this.list2,
                        onChanged: (value) {
                          list(value);
                        },
                      )
                    ],
                  )
                ],
              ));
        });
  }

  var list2 = <DropdownMenuItem>[
    DropdownMenuItem(
      child: Text('data'),
      value: 'data',
    ),
    DropdownMenuItem(
      child: Text('data 2'),
      value: 'data 2',
    )
  ];

  void list(value) {
    if (value == 'data') {
      setState(() {
        this.list2 = <DropdownMenuItem>[
          DropdownMenuItem(
            child: Text('data'),
            value: 'data',
          ),
          DropdownMenuItem(
            child: Text('data 2'),
            value: 'data 2',
          )
        ];
      });
    } else {
      setState(() {
        this.list2 = <DropdownMenuItem>[
          DropdownMenuItem(
            child: Text('data 2'),
            value: 'data 2',
          ),
          DropdownMenuItem(
            child: Text('data'),
            value: 'data',
          )
        ];
      });
    }
  }
}
