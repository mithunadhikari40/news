import 'package:news/src/models/news_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CommentBloc {
  final PublishSubject _commentFetcher = PublishSubject<int>();
  final BehaviorSubject _commentsOutput =
      BehaviorSubject<Map<int, Future<NewsModel>>>();
  final _repository = Repository();

  //sinks

  Function(int) get fetchItemWithComments => _commentFetcher.sink.add;
  //streams

  ValueObservable<Map<int, Future<NewsModel>>> get itemWithComment =>
      _commentsOutput.stream;

  CommentBloc() {
    _commentFetcher.stream
        .transform(_commentTransformer())
        .pipe(_commentsOutput);
  }
  _commentTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<NewsModel>>>(
      (Map<int, Future<NewsModel>> cache, int id, int index) {
        Future<NewsModel> model = _repository.fetchItem(id);
        cache[id] = model;

        model.then((NewsModel item) {
          //take that item and recrusively fetch all of its kids item and then the kids kids as well


          // if(item.kids!=null){
          //   item.kids?.forEach((kidId) {
          //   return fetchItemWithComments(kidId);
          // });

          // }
          item.kids?.forEach((kidId) {
            return fetchItemWithComments(kidId);
          });
        });

        return cache;
      },
      <int, Future<NewsModel>>{},
    );
  }

  dispose() {
    _commentFetcher.close();
    _commentsOutput.close();
  }
}
