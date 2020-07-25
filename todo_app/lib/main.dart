import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/page/allpage/allpage.dart';
import 'package:todoapp/page/completepage/complete.dart';
import 'package:todoapp/page/incompletepage/incomplete.dart';
import 'package:todoapp/provider/provider.dart';
import 'package:todoapp/service/firebase.dart';
import 'package:todoapp/widget/addtask.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskProvider()),
          StreamProvider(create: (context) => firestoreService.getTasks()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _tabLists = [AllPage(), CompletePage(), IncompletePage()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(children: [
        Positioned(
          width: 200,
          height: 300,
          top: 90,
          right: 200,
          child: Image.asset(
            'assets/images/aqua.gif',
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          width: 200,
          height: 300,
          top: 90,
          left: 30,
          child: Image.asset(
            'assets/images/kazuma.gif',
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          width: 200,
          height: 300,
          top: 90,
          left: 120,
          child: Image.asset(
            'assets/images/megumin.gif',
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          width: 200,
          height: 300,
          top: 90,
          left: 200,
          child: Image.asset(
            'assets/images/darkness.gif',
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          child: Text(
            "Todos",
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          top: 40,
          left: 20,
        ),
        DraggableScrollableSheet(
            maxChildSize: 1,
            minChildSize: 0.1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Stack(overflow: Overflow.visible, children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40)),
                    ),
                    child: _tabLists.elementAt(_selectedIndex))
              ]);
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (_) => AddTask(isEditMode: false));
        },
        tooltip: 'Add a new task!',
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            title: Text('Complete'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close),
            title: Text('Incomplete'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[900],
        onTap: _onItemTapped,
      ),
    );
  }
}
