import 'package:rxdart/rxdart.dart';
import '../models/item.dart';
import '../resources/repository.dart';
import 'dart:async';

class CommentsBloc{
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<Item>>>();

  //Streams
  Stream<Map<int, Future<Item>>> get itemWithComments => _commentsOutput.stream;

  //Sinks
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer())
      .pipe(_commentsOutput);
  }

  _commentsTransformer(){
    return ScanStreamTransformer<int, Map<int, Future<Item>>>(
      (cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        cache[id].then((Item item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });
        return cache;
      },
      <int, Future<Item>>{}
    );
  }

  dispose(){
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}