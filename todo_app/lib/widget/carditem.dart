import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final bool isDone;
  final String description;

  CardItem({this.isDone, this.description});

  Widget build(BuildContext context) {
    if (isDone) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            description,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough),
          ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          description,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
