import 'package:flutter/material.dart';
import 'package:news/src/bloc/stories_provider.dart';
import 'package:news/src/models/news_model.dart';
import 'package:news/src/widgets/loading.dart';

class NewsListTile extends StatelessWidget {
  final int id;
  NewsListTile(this.id);

  @override
  Widget build(BuildContext context) {
    final StoryBloc bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.itemOutput,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<NewsModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        return FutureBuilder(
          future: snapshot.data[id],
          builder:
              (BuildContext context, AsyncSnapshot<NewsModel> anotherSnapshot) {
            if (!anotherSnapshot.hasData) {
              return Loading();
            }
            return buildNewsListTile(anotherSnapshot.data, context);
          },
        );
      },
    );
  }

  Widget buildNewsListTile(NewsModel model, BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/details', arguments: model.id);
          },
          title: Text(model.title),
          subtitle: Text('By: ${model.by}'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${model.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        )
      ],
    );
  }

}
