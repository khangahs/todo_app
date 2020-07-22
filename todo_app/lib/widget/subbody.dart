import 'package:flutter/material.dart';
import 'package:todoapp/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/modal/task.dart';
import 'package:todoapp/widget/subcard.dart';

class SubListItem extends StatefulWidget {
  final Task task;

  SubListItem(this.task);

  @override
  _SubListItemState createState() => _SubListItemState();
}

class _SubListItemState extends State<SubListItem> {
  @override
  Widget build(BuildContext context) {
    return TheSubCard(widget.task);
  }
}

class SubBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskList = Provider.of<List<Task>>(context);
    return (taskList != null)
        ? ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return SubListItem(taskList[index]);
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
