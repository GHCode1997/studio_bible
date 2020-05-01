import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studio_bible/services/biblia.service.dart';
import 'package:studio_bible/services/locator.service.dart';
import 'package:studio_bible/views/libro.view.dart';

class BibliaView extends StatefulWidget {
  BibliaView({Key key}): super(key: key);

  _BibliaViewState createState() => _BibliaViewState();
}

class _BibliaViewState extends State<BibliaView> {
 List<String> _libros = List<String>();
 List<String> _numCap = List<String>();
  initState() {
    super.initState();
    BibliaService().getBible()
    .then((value){
      Map<String,dynamic> response = json.decode(value.body);
      List<dynamic> list = response['books'];
      list.forEach((element) {
        setState(() {
          this._libros.add(element['name']);
          this._numCap.add(element['chapters']);
        });
       });
    });
  }


Widget build(BuildContext context){
  return Scaffold(
    body: ListView.builder(
      itemCount: _libros.length,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Text(_libros[index]),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> LibroView(length: int.parse(_numCap[index]),libro: _libros[index])));
          },
        );
    },
  ));
}
}