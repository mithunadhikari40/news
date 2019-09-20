import 'package:flutter/material.dart';
import 'package:news/src/bloc/stories_provider.dart';
import 'package:news/src/widgets/news_list_tile.dart';
import 'package:news/src/widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
//this is bad practise
    // bloc.addItems();

    return Scaffold(
      appBar: AppBar(
        title: Text("News app"),
      ),
      body: Center(
        child: buildNewsList(bloc),
      ),
    );
  }

  Widget buildNewsList(StoryBloc bloc) {
    return Refresh(

refresh:() async {
        await bloc.clearCache();
        await bloc.addItems();
      }


      child: StreamBuilder(
        stream: bloc.topIds,
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              //somehow call the fetchitem method
              bloc.fetchItem(snapshot.data[index]);
              return NewsListTile(snapshot.data[index]);
            },
          );
        },
      ),
    );
  }

  // Widget buildFutureItems() {
  //   return ListView.builder(
  //     itemCount: 500,
  //     itemBuilder: (BuildContext context, int index) {
  //       return FutureBuilder(
  //         future: makeFuture(),
  //         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
  //           if (!snapshot.hasData) {
  //             return Text("Still have not fetched the data");
  //           }
  //           return Text("I am the data ${snapshot.data}");
  //         },
  //       );
  //     },
  //   );
  // }

  // Future<String> makeFuture() {
  //   return Future.delayed(
  //     Duration(seconds: 4),
  //     () {
  //       return "some fake data";
  //     },
  //   );
  // }
}
