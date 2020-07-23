import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/widget/addtask.dart';
import 'package:todoapp/widget/card.dart';
import 'package:todoapp/modal/task.dart';

class MainListItem extends StatefulWidget {
  final Task task;

  MainListItem(this.task);

  @override
  _MainListItemState createState() => _MainListItemState();
}

class _MainListItemState extends State<MainListItem> {
  @override
  Widget build(BuildContext context) {
    return TheCard(widget.task);
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final taskList = Provider.of<List<Task>>(context);
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
                        return ListTile(
                          title: Text(dbRef[index]["description"]),
                          subtitle: Text(dbRef[index]["taskId"]),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) => AddTask(isEditMode: true));
                          },
                        );
                      },
                    );
          }
        });
  }
}
