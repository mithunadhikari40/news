import 'package:flutter/material.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';

void main() {
  test('sample test case', () {
//setup the test case
    final sum = 1 + 5;
    expect(6, sum);
  });

  test('fetch top ids function test', () async {
    final newsApiProvider = NewsApiProvider();
    newsApiProvider.client = MockClient((Request request) async {
      var jsonList = json.encode([1, 2, 3, 400]);
      return Response(jsonList, 200);
    });
    final ids = await newsApiProvider.fetchTopStories();
    expect(ids, [1, 2, 3, 400]);
  });

  test('fetch indivisual item test', () async {
    final newsApiProvider = NewsApiProvider();
    newsApiProvider.client = MockClient((Request request) async {
      final data = {
        "by": "dhouston",
        "descendants": 71,
        "id": 8863,
        "kids": [8952, 9224],
        "score": 111,
        "time": 1175714200,
        "title": "My YC app: Dropbox - Throw away your USB drive",
        "type": "story",
        "url": "http://www.getdropbox.com/u/2/screencast.html"
      };

      var jsonList = json.encode(data);
      return Response(jsonList, 200);
    });
    final response = await newsApiProvider.fetchItem(8863);
    expect(response.score, 111);
  });
}
