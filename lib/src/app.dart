import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'blocs/providers/stories_provider.dart';
import 'blocs/providers/comments_provider.dart';

class App extends StatelessWidget{
  final _title = 'Hacker News';

  @override
  Widget build(BuildContext context){
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: _title,
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings){
    return MaterialPageRoute(
      builder: (context){
        if (settings.name == '/'){
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();
          return NewsList(bloc: storiesBloc);
        } else {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));
          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetail(itemId: itemId, bloc: commentsBloc);
        }
      }
    );
  }
}