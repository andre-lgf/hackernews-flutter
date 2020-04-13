import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item.dart';
import 'source.dart';
import 'cache.dart';

class Repository{
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<Item> fetchItem(int id) async {
    Item item;
    var source;

    for(source in sources){
      item = await source.fetchItem(id);
      if(item != null){
        break;
      }
    }

    for(var cache in caches){
      if(cache != source){
        cache.addItem(item);
      }
    }

    return item;
  }

  clearCache() async {
    for(var cache in caches){
      await cache.clear();
    }
  }
}