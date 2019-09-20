import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news/src/bloc/comment_provider.dart';
import 'package:news/src/bloc/stories_provider.dart';
import 'package:news/src/screens/news_details.dart';
import 'package:news/src/screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StoriesProvider(
        child: CommentProvider(
      child: MaterialApp(
        title: 'News app',
        theme: ThemeData.light(),
        // home: NewsList(),
        onGenerateRoute: (RouteSettings settings) {
          return generateRoute(settings);
        },
      ),
    ));
  }

  generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final bloc = StoriesProvider.of(context);
          bloc.addItems();
          return NewsList();
        },
      );
    } else if (settings.name == '/details') {
      int id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final commentBloc = CommentProvider.of(context);
          commentBloc.fetchItemWithComments(id);
          return NewsDetail(newsId: id);
        },
      );
    }
  }
}
