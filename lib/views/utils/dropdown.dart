
import 'package:flutter/material.dart';

class DropdownInput extends StatefulWidget {
  DropdownInput({Key key,this.opciones}) : super(key: key);

  @override
  _DropdownInputState createState() => _DropdownInputState();

  String select = "One";
  List<String> opciones;
}

class _DropdownInputState extends State<DropdownInput> {

  @override
  void setState(fn) {
    super.setState(fn);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.select,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (value){
        setState(() {
          widget.select = value;
        });
      },
      items: widget.opciones
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}