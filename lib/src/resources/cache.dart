import '../models/item.dart';

abstract class Cache{
  Future<int> addItem(Item item);

  Future<int> clear();
}