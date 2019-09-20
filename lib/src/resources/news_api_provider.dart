import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:news/src/models/news_model.dart';
import 'repository.dart';

const _rootUrl = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider implements Source {
  Client client = Client();

  @override
  Future<List<int>> fetchTopStories() async {
    final response = await client.get("$_rootUrl/topstories.json");
    print("the ids respons from the server $response");
    final ids = json.decode(response.body);
    print("The cast list of integer is $ids");
    return ids.cast<int>();
  }

  @override
  Future<NewsModel> fetchItem(int id) async {
    final response = await client.get("$_rootUrl/item/$id.json");
    final res = json.decode(response.body);
    final NewsModel model = NewsModel.fromJson(res);
    //add thsi model to the local db
    return model;
  }
}
