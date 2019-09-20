import 'package:news/src/bloc/stories_provider.dart';
import 'package:news/src/models/news_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoryBloc {
  Repository _repository = Repository();
  PublishSubject _topIds = PublishSubject<List<int>>();
  PublishSubject _itemFetcher = PublishSubject<int>();

  final _itemOuptut = BehaviorSubject<Map<int, Future<NewsModel>>>();

  ValueObservable<Map<int, Future<NewsModel>>> get itemOutput =>
      _itemOuptut.stream;

  //getter for fetchin the items
  Function(int) get fetchItem => _itemFetcher.sink.add;

  Observable<List<int>> get topIds => _topIds.stream;

  addItems() async {
    List<int> data = await _repository.fetchTopStories();
    _topIds.sink.add(data);
  }

  StoryBloc() {
    _itemFetcher.stream.transform(_itemTransformer()).pipe(_itemOuptut);
  }

  dispose() {
    _topIds.close();
    _itemFetcher.close();
    _itemOuptut.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<NewsModel>> cache, int id, int index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<NewsModel>>{},
    );
  }

  clearCache() {
    return _repository.clearCache();
  }
}
