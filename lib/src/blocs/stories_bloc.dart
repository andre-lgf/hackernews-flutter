import 'package:rxdart/rxdart.dart';
import '../models/item.dart';
import '../resources/repository.dart';
import 'dart:async';

class StoriesBloc{
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<Item>>>();
  final _itemsFetcher = PublishSubject<int>();

  // Getters to Streams
  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int, Future<Item>>> get items => _itemsOutput.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc(){
    _itemsFetcher.stream.transform(_itemsTransformer())
      .pipe(_itemsOutput);
  }

  fetchTopIds() async {
    _topIds.sink.add(await _repository.fetchTopIds());
  }

  clearCache(){
    return _repository.clearCache();
  }

  _itemsTransformer(){
    return ScanStreamTransformer(
      (Map<int, Future<Item>> cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<Item>>{}
    );
  }

  dispose(){
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}