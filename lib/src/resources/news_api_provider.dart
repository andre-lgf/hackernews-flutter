import '../models/item.dart';
import 'source.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';

const _BASE_URL = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source{
  Client client = Client();

  Future<List<int>> fetchTopIds() async{
    return await client.get('$_BASE_URL/topstories.json')
      .then((response) => json.decode(response.body).cast<int>());
  }

  Future<Item> fetchItem(int id) async{
    return await client.get('$_BASE_URL/item/$id.json')
      .then((response) => Item.fromJson(json.decode(response.body)));
      //.catchError((error) => error);
  }
}