import 'package:flutter/material.dart';
import 'story_bloc.dart';
export 'story_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoryBloc bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  StoriesProvider({Key key, Widget child})
      : bloc = StoryBloc(),
        super(key: key, child: child);

  static StoryBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }
}
