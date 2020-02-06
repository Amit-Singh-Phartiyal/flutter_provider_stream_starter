import 'package:flutter/material.dart';
import 'package:flutter_provider_stream_starter/blocs/tab1_bloc.dart';
import 'package:flutter_provider_stream_starter/blocs/tab2_bloc.dart';
import 'package:flutter_provider_stream_starter/blocs/tab3_bloc.dart';
import 'package:flutter_provider_stream_starter/screens/tab1.dart';
import 'package:flutter_provider_stream_starter/screens/tab2.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => Tab1Bloc()),
        ChangeNotifierProvider(builder: (_) => Tab2Bloc()),
        Provider(builder: (_) => Tab3Bloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Tab1(),
          '/second': (context) => Tab2(),
        },
        // home: Tab1(),
      ),
    );
  }
}
