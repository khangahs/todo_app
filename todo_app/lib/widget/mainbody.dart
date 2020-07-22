import 'package:flutter/material.dart';
import 'package:todoapp/provider/provider.dart';
import 'package:provider/provider.dart';
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
    final taskList = Provider.of<List<Task>>(context);
    return (taskList != null)
        ? ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return MainListItem(taskList[index]);
            },
          )
        : LayoutBuilder(
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
          );
  }
}
