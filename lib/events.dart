import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  EventsPage({Key key, this.title}) : super(key: key);

  final String title;
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(child: Column()),
    );
  }
}
