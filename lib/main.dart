import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/app.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(App());
}
