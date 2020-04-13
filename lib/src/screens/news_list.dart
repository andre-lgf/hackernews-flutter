import 'package:flutter/material.dart';
import '../blocs/stories_bloc.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget{
  final _title = 'News List';
  final StoriesBloc bloc;

  NewsList({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(_title),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc){
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        return !snapshot.hasData
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Refresh(
              bloc: bloc,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index){
                  bloc.fetchItem(snapshot.data[index]);
                  return NewsListTile(
                    itemId: snapshot.data[index],
                  );
                },
              ),
            );
      },
    );
  }
}