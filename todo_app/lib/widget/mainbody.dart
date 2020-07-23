import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/widget/addtask.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('tasks').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final dbRef = snapshot.data.documents;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              return (!snapshot.hasData)
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                'No tasks here...',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: dbRef.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: ValueKey(dbRef[index]["taskId"]),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'DELETE',
                                  style: TextStyle(
                                    color: Theme.of(context).errorColor,
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.delete,
                                  color: Theme.of(context).errorColor,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                          onDismissed: (direction) {
                            Provider.of<TaskProvider>(context, listen: false)
                                .removeTask(dbRef[index]["taskId"]);
                          },
                          child: ListTile(
                            title: Text(dbRef[index]["description"]),
                            subtitle: Text(dbRef[index]["taskId"]),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) => AddTask(
                                      taskId: dbRef[index]["taskId"],
                                      description: dbRef[index]["description"],
                                      isEditMode: true));
                            },
                          ),
                        );
                      },
                    );
          }
        });
  }
}
