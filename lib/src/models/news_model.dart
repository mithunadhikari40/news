import 'dart:convert';

class NewsModel {
  int id;
  bool deleted;
  String type;
  String by;
  int time;
  String text;
  bool dead;
  int parent;
  List<dynamic> kids;
  String url;
  int score;
  String title;
  int descendants;

  NewsModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    deleted = map["deleted"] ?? false;
    type = map["type"];
    by = map["by"];
    time = map["time"];
    text = map["text"] ?? '';
    dead = map["dead"] ?? false;
    parent = map["parent"];
    kids = map["kids"];
    url = map["url"];
    score = map["score"];
    title = map["title"] ?? '';
    descendants = map["descendants"];
  }

  NewsModel.fromDb(Map<String, dynamic> dbData) {
    id = dbData["id"];
    deleted = dbData["deleted"] == 1;
    type = dbData["type"];
    by = dbData["by"];
    time = dbData["time"];
    text = dbData["text"];
    dead = dbData["dead"] == 1;
    parent = dbData["parent"];
    kids = jsonDecode(dbData["kids"]);
    url = dbData["url"];
    score = dbData["score"];
    title = dbData["title"];
    descendants = dbData["descendants"];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "deleted": deleted ? 1 : 0,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "dead": dead ? 1 : 0,
      "parent": parent,
      "kids": jsonEncode(kids),
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
    };
  }
}
