import 'package:flutter/material.dart';
import '../models/item.dart';
import '../blocs/comments_bloc.dart';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget{
  final int itemId;
  final CommentsBloc bloc;

  NewsDetail({@required this.itemId, @required this.bloc});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Details'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc){
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<Item>>> snapshot) {
        return !snapshot.hasData
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<Item> itemSnapshot){
              return !itemSnapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : buildList(itemSnapshot.data, snapshot.data);
            }
          );
      },
    );
  }

  Widget buildList(Item item, Map<int, Future<Item>> itemMap){
    final children = <Widget>[];
    children.add(buildTitle(item));
    children.addAll(
      item.kids.map((kidId) { 
        return Comment(itemId: kidId, itemMap: itemMap, depth: 0); 
      }).toList()
    );

    return ListView(
        children: children,
      );
  }

  Widget buildTitle(Item item){
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
          item.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
    );
  }
}