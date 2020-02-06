import 'package:flutter/material.dart';
import 'package:flutter_provider_stream_starter/screens/tab3.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_stream_starter/blocs/tab1_bloc.dart';
import 'package:flutter_provider_stream_starter/screens/tab2.dart';

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Simple Provider",
              ),
              Tab(
                text: "With issue",
              ),
              Tab(
                text: "Solution",
              ),
            ],
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            Column(
              children: <Widget>[
                RaisedButton(
                    child: Text('Get Todo'),
                    onPressed: () {
                      Provider.of<Tab1Bloc>(context, listen: false)
                          .getTodoData();
                    }),
                Divider(),
                Consumer<Tab1Bloc>(builder: (context, bloc, child) {
                  var value = 'No data';
                  if (bloc.loading) {
                    value = 'Loading...';
                  } else {
                    if (bloc.todoModel != null) {
                      value = bloc.todoModel.toString();
                    }
                  }
                  return Text(value);
                }),
              ],
            ),
            Tab2(),
            Tab3()
          ],
        ),
      ),
    );
  }
}
