import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Divider(indent: 18.0, endIndent: 8.0, thickness: 1.0)),
        Text("OR", style: TextStyle(fontWeight: FontWeight.w600)),
        Expanded(child: Divider(indent: 8.0, endIndent: 18.0, thickness: 1.0)),
      ],
    );
  }
}
