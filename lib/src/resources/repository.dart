import 'dart:async';
import 'package:news/src/models/news_model.dart';
import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository {
  List<Source> sources = [
    dbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = [
    dbProvider,
  ];

  Future<List<int>> fetchTopStories() async {
    return sources[1].fetchTopStories();
  }

  Future<NewsModel> fetchItem(int id) async {
    NewsModel model;
    Source source;

    for (source in sources) {
      model = await source.fetchItem(id);
      if (model != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source) cache.addItem(model);
    }
    return model;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clearCache();
    }
  }
}

abstract class Source {
  Future<NewsModel> fetchItem(int id);
  Future<List<int>> fetchTopStories();
}

abstract class Cache {
  Future<int> addItem(NewsModel model);
  Future<int> clearCache();
}
