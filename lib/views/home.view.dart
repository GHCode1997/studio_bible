import 'package:flutter/material.dart';
import 'package:studio_bible/views/bible.view.dart';
import 'package:studio_bible/views/category.view.dart';

/// HomeView
/// This class is a StatefulWidget, It have proposed show the principal theme of the application

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
        iconMargin: EdgeInsets.only(top: 0),
        icon: Icon(Icons.library_books),
        text: 'Biblia'),
    Tab(icon: Icon(Icons.category), text: 'Categorias'),
    Tab(
      icon: Icon(Icons.games),
      text: 'Juegos',
    )
  ];
  int index = 0;
  TabController _tabController;

  initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TabBarView(

    //         controller: _tabController,
    //         children: myTabs.map((Tab e){
    //           String label;
    //             if(widget.item =="categorias" && e.text.toLowerCase() == "categorias"){
    //               label = "categorias";
    //             }else {
    //               label = e.text.toLowerCase();
    //             }
    //           switch(label){
    //             case 'categorias':
    //             return CategoriesView();
    //             default:
    //             return Center(child: Text(
    //             'This is the $label tab',
    //             style: const TextStyle(fontSize: 30)
    //           ) );
    //           }

    //         }).toList()
    //       ),
    var listBody = [
      BibliaView(),
      CategoriesView(),
      Center(
          child: Text('This is the  tab', style: const TextStyle(fontSize: 30)))
    ];
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Drawer Header',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Messages'),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text('Studio Bible'),
              bottom: TabBar(
                controller: _tabController,
                tabs: myTabs,
                onTap: (index) {
                  setState(() {
                    this.index = index;
                  });
                },
              ),
            ),
            body: listBody[this.index]));
  }
}
