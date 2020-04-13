import 'dart:convert';

class Item{
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  Item.fromJson(Map<String, dynamic> parsedJson)
    : id = parsedJson['id'],
      deleted = parsedJson['deleted'] ?? false,
      type = parsedJson['type'],
      by = parsedJson['by'] ?? '',
      time = parsedJson['time'],
      text = parsedJson['text'] ?? '',
      dead = parsedJson['dead'] ?? false,
      parent = parsedJson['parent'],
      kids = parsedJson['kids'] ?? [],
      url = parsedJson['url'],
      score = parsedJson['score'],
      title = parsedJson['title'],
      descendants = parsedJson['descendants'] ?? 0;

  Item.fromDb(Map<String, dynamic> columns)
    : id = columns['id'],
      deleted = columns['deleted'] == 1,
      type = columns['type'],
      by = columns['by'],
      time = columns['time'],
      text = columns['text'],
      dead = columns['dead'] == 1,
      parent = columns['parent'],
      kids = jsonDecode(columns['kids']),
      url = columns['url'],
      score = columns['score'],
      title = columns['title'],
      descendants = columns['descendants'];

  Map<String, dynamic> toMap(){
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