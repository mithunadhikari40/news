import 'package:flutter/material.dart';
import 'package:news/src/bloc/comment_bloc.dart';
export 'comment_bloc.dart';

class CommentProvider extends InheritedWidget {
  final CommentBloc bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  CommentProvider({Key key, Widget child})
      : bloc = CommentBloc(),
        super(key: key, child: child);

  static CommentBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CommentProvider)
            as CommentProvider)
        .bloc;
  }
}
