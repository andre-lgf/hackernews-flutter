import 'package:hacker_news/src/models/item.dart';
import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main(){
  test('FetchTopIds returns a list of Ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async{
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    expect(await newsApi.fetchTopIds(), [1, 2, 3, 4]);

  });

  group('FetchItem returns a Item', (){
    final newsApi = NewsApiProvider();
    final jsonMap = { "by" : "dhouston",
                      "descendants" : 71,
                      "id" : 8863,
                      "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
                      "score" : 111,
                      "time" : 1175714200,
                      "title" : "My YC app: Dropbox - Throw away your USB drive",
                      "type" : "story",
                      "url" : "http://www.getdropbox.com/u/2/screencast.html" };
    newsApi.client = MockClient((request) async{
      return Response(json.encode(jsonMap), 200);
    });

    test('should return an Item Object', () async {
      final response = await newsApi.fetchItem(123);
      expect(response, isA<Item>());
    });

    test('should return an Item of the same Id', () async {
      final response = await newsApi.fetchItem(8863);
      expect(response.id, 8863);
      expect(response.id, Item.fromJson(jsonMap).id);
    });
  });
}