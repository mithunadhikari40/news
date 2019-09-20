import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        color: Colors.grey[200],
        height: 50,
      ),
      subtitle: Container(
        height: 25,
        color: Colors.grey[200],
      ),
    );
  }
}
