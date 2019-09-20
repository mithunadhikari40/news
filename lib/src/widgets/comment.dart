import 'package:flutter/material.dart';
import 'package:news/src/models/news_model.dart';
import 'package:news/src/widgets/loading.dart';
import 'package:flutter_html/flutter_html.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<NewsModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<NewsModel> snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        return buildList(snapshot.data);
      },
    );
  }

  Widget buildList(NewsModel data) {
    final commentList = [];

    data.kids?.forEach((kidId) {
      var comment = Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: depth + 1,
      );
      commentList.add(comment);
    });

//    final children = <Widget>[
//      Text(data.text),
//      Divider(
//        height: 12.0,
//      ),
//    ];

    //  data.kids?.forEach((kidId) {
    //    var comment = Comment(
    //       itemId: kidId,
    //       itemMap: itemMap,
    //     );
    //     commentList.add(comment);
    //  });

    return Column(
      children: <Widget>[
        buildTitle(data),
        Divider(
          height: 12.0,
        ),
        ...commentList,
      ],
    );
  }

  buildTitle(NewsModel data) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: depth * 16.0, right: 16.0),
      title: Html(
        data: data.text,
      ),
      subtitle:
      data.by==null? Text("Deleted"):
       Text('By ${data.by}'),
    );
  }
}
