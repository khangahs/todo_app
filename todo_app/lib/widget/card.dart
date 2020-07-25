import 'package:flutter/material.dart';
import 'package:todoapp/widget/addtask.dart';
import 'package:todoapp/widget/carditem.dart';

class TheCard extends StatelessWidget {
  final String taskId;
  final String description;
  final bool isDone;

  TheCard({this.taskId, this.description, this.isDone});

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
