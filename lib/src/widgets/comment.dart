import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hacker_news/src/widgets/loading_container.dart';
import '../models/item.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class Comment extends StatelessWidget{
  final int itemId;
  final Map<int, Future<Item>> itemMap;
  final int depth;

  Comment({@required this.itemId, @required this.itemMap, @required this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<Item> snapshot){
        return !snapshot.hasData
          ? LoadingContainer()
          : buildComments(snapshot);
      },
    );
  }

  Widget buildComments(AsyncSnapshot<Item> snapshot){
    final item = snapshot.data;
    final children = <Widget>[
      ListTile(
        contentPadding: EdgeInsets.only(
          left: (depth + 1) * 16.0, 
          right: 16.0
        ),
        title: buildText(item),
        subtitle: item.by == ''
          ? Text('Deleted') 
          : Text(item.by),
      ),
      Divider(),
    ];
    item.kids.forEach((kidId) {
      children.add(Comment(itemId: kidId, itemMap: itemMap, depth: depth + 1));    
    });
    return Column(children: children);
  }

  Widget buildText(Item item){
    /*final text = item.text
      .replaceAll(RegExp(r'(<script(\s|\S)*?<\/script>)|(<style(\s|\S)*?<\/style>)|(<!--(\s|\S)*?-->)|(<\/?(\s|\S)*?>)'), '')
      .replaceAll('&#x27;', "'")
      .replaceAll('&#x2F;', "/")
      .replaceAll("&quot;", '"')
      .replaceAll("&lt;", '<')
      .replaceAll("&gt;", '>');*/
    return Html(
      data: item.text,
      onLinkTap: _launchInBrowser,
    );
  }

  Future<void> _launchInBrowser(String url) async{
    if(await canLaunch(url)){
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}