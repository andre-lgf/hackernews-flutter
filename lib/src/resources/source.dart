import '../models/item.dart';

abstract class Source{
  Future<List<int>> fetchTopIds();

  Future<Item> fetchItem(int id); 
}