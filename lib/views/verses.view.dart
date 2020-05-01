import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studio_bible/services/biblia.service.dart';
import 'package:studio_bible/services/locator.service.dart';

class VersesView extends StatefulWidget {
  VersesView({this.libro,this.cap});
_VersesView createState() => _VersesView();
final String libro;
final String cap;
}
class _VersesView extends State<VersesView> {

  List<String> text = List<String>();
  List<String> verses = List<String>();

  initState(){
    super.initState();
    locator<BibliaService>().getLibroVerses(widget.libro, widget.cap)
    .then((value){
      List<dynamic> respuesta = json.decode(value.body.split("|")[0]);
      setState(() {
        respuesta.forEach((element) {
          this.text.add(element['text']);
          this.verses.add(element['verse'].toString());
        });
      });
    });
  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.libro+ " "+widget.cap),
      ),
      body: ListView.builder(
        itemCount: this.text.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text(this.verses[index],),
            subtitle: Text(this.text[index]),
          );
        },
      ),
    );
  }
}