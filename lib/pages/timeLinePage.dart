//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:socialmedia/widgets/headerWidget.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true,),
    );
  }
}
