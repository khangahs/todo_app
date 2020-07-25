import 'package:flutter/material.dart';
import 'package:todoapp/widget/addtask.dart';
import 'package:todoapp/widget/carditem.dart';

class TheCard extends StatelessWidget {
  String taskId;
  String description;
  bool isDone;

  TheCard(
      {@required this.taskId,
      @required this.description,
      @required this.isDone});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: CardItem(isDone: isDone, description: description),
      value: isDone,
      onChanged: (_) {
        showModalBottomSheet(
            context: context,
            builder: (_) => AddTask(
                taskId: taskId,
                description: description,
                isDone: isDone,
                isEditMode: true));
      },
    );
  }
}
