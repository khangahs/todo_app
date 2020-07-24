import 'package:flutter/material.dart';
import 'package:todoapp/widget/carditem.dart';
import 'package:todoapp/modal/task.dart';

class TheCard extends StatefulWidget {
  final Task task;

  TheCard(this.task);

  @override
  _TheCardState createState() => _TheCardState();
}

class _TheCardState extends State<TheCard> {
  void _checkItem() {
    setState(() {
//      Provider.of<TaskProvider>(context, listen: false)
//          .changeStatus(false, Task(isDone: false));
    });
  }

//  Future<dynamic> checkLEDStatus() async {
//    DocumentSnapshot snapshot =
//    await db.collection('LEDStatus').document('LEDStatus').get();
//    return snapshot.data['LEDOn'];
//  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _checkItem,
        child: CheckboxListTile(
          title: CardItem(widget.task.isDone, widget.task.description),
          value: widget.task.isDone,
          onChanged: (_) => _checkItem(),
          secondary: const Icon(Icons.hourglass_empty),
        ));
  }
}
