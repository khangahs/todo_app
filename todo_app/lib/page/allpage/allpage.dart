import 'package:flutter/material.dart';
import 'package:todoapp/widget/mainbody.dart';

class AllPage extends StatefulWidget {
  @override
  _AllPageState createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  Widget build(BuildContext context) {
    return Scaffold(body: MainBody());
  }
}
