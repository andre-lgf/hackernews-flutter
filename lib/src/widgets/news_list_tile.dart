import 'package:flutter/material.dart';
import 'package:hacker_news/src/widgets/loading_container.dart';
import '../models/item.dart';
import '../blocs/providers/stories_provider.dart';
import 'dart:async';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({@required this.itemId});

  Widget build(context){
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<Item>>> snapshot) {
        return !snapshot.hasData
          ? LoadingContainer()
          : FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<Item>itemSnapshot){
              return !itemSnapshot.hasData
                ? LoadingContainer(hasTrailing: true)
                : buildTile(context, itemSnapshot.data);
            }
          );
      }
    );
  }

  Widget buildTile(BuildContext context, Item item){
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}