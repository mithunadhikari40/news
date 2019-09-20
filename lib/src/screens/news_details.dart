import 'package:flutter/material.dart';
import 'package:news/src/bloc/comment_bloc.dart';
import 'package:news/src/bloc/comment_provider.dart';
import 'package:news/src/models/news_model.dart';
import 'package:news/src/widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int newsId;
  NewsDetail({this.newsId});

  @override
  Widget build(BuildContext context) {
    final CommentBloc bloc = CommentProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComment,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<NewsModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return FutureBuilder(
          future: snapshot.data[newsId],
          builder:
              (BuildContext context, AsyncSnapshot<NewsModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return buildList(snapshot.data, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(Map<int, Future<NewsModel>> itemMap, NewsModel model) {
    final commentList = model.kids?.map((kidId) {
      return Comment(itemId: kidId, itemMap: itemMap,depth: 1,);
    })?.toList();

    return ListView(
      children: <Widget>[
        buildTitle(model),
        ...commentList,
      ],
    );
  }

  Widget buildTitle(NewsModel model) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(8.0),
      child: Text(
        model.title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
