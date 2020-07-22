import 'package:flutter/material.dart';
import 'package:todoapp/widget/carditem.dart';
import 'package:todoapp/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/modal/task.dart';

class TheSubCard extends StatefulWidget {
  final Task task;

  TheSubCard(this.task);

  @override
  _TheSubCardState createState() => _TheSubCardState();
}

class _TheSubCardState extends State<TheSubCard> {
  void _checkItem() {
    setState(() {
      Provider.of<TaskProvider>(context, listen: false).optionCheck(true);
    });
  }

  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(widget.task.taskId),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          Provider.of<TaskProvider>(context, listen: false)
              .removeTask(widget.task.taskId);
        },
        background: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
        child: GestureDetector(
          onTap: _checkItem,
          child: Container(
            height: 70,
            child: Card(
              elevation: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: widget.task.isDone,
                        onChanged: (_) => _checkItem(),
                      ),
                      CardItem(
                        widget.task.isDone,
                        widget.task.description,
                      ),
                    ],
                  ),
                  if (widget.task.isDone)
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {},
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
