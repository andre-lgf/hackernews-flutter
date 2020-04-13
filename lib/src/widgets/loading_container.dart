import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget{
  final bool hasTrailing;

  LoadingContainer({this.hasTrailing = false});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
          trailing: buildTrailing(),
        ),
        Divider(height: 8.0),
      ],
    );
  }

  Widget buildContainer({
      double height = 25.0, 
      double width = 150, 
      EdgeInsets margin = const EdgeInsets.only(top: 5.0, bottom: 5.0),
    }){
    return Container(
      color: Colors.grey[200],
      height: height,
      width: width,
      margin: margin,
    );
  }

  Widget buildTrailing(){
    return hasTrailing 
      ? Column(
          children: <Widget>[
            Icon(Icons.comment),
            buildContainer(
              width: 30.0, 
              height: 15.0, 
              margin: EdgeInsets.all(0.0)
            ),
          ],
        )
      : null;
  }
}