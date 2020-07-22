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
          StreamProvider(create: (context) => firestoreService.getTasks())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Todo App"),
      ),
      body: _tabLists.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => AddTask(isEditMode: false),
          );
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
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
