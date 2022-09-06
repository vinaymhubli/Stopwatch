import 'package:flutter/material.dart';
import 'package:stop_watch_app/views/stopwatch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SIMPLE STOPWATCH APP",
      debugShowCheckedModeBanner: false,
      home: StopwatchHome(),
    );
  }
}
