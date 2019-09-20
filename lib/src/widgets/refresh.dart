import 'package:flutter/material.dart';
import 'package:news/src/bloc/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  final Function refresh;

  Refresh({this.child,this.refresh});

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      child: child,
      onRefresh: refresh,
    );
  }
}
