import 'package:flutter/material.dart';
import 'package:todoapp/widget/subbody.dart';

class CompletePage extends StatefulWidget {
  @override
  _CompletePageState createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
  Widget build(BuildContext context) {
    return Scaffold(body: SubBody());
  }
}
