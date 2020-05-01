import 'package:flutter/material.dart';
import 'package:studio_bible/views/verses.view.dart';

class LibroView extends StatefulWidget {
  final int length;
  final String libro;
  LibroView({this.length, this.libro});
  _LibroViewState createState() => _LibroViewState();
}

class _LibroViewState extends State<LibroView> {
  List<Container> listNumber = List<Container>();

  initState() {
    print('init');
    super.initState();

    setState(() {
      for (int i = 1; i < widget.length + 1; i++) {
        this.listNumber.add(Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                title: Text( i.toString(), textAlign: TextAlign.center, style:  TextStyle(fontSize: 13),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VersesView(libro: widget.libro,cap: i.toString(),)));
                },
              ),
            ),
            color: Colors.teal[100]));
      }
    });
    print('object ' + this.widget.libro);
    print('object ' + this.widget.length.toString());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.libro),
        ),
        body: GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 5,
          children: listNumber,
        ));
  }
}
