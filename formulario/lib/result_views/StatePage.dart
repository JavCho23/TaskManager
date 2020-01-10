import 'package:flutter/material.dart';

class StatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatePageState();
  }
}

class StatePageState extends State<StatePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Estados'),
    );
  }
}
