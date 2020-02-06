import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_stream_starter/blocs/tab3_bloc.dart';

class Tab3 extends StatefulWidget {
  @override
  _Tab3State createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  @override
  Widget build(BuildContext context) {
    print('build Tab3');
    return Scaffold(
      body: Column(
        children: <Widget>[
          RaisedButton(
              child: Text('Get Todo'),
              onPressed: () {
                Provider.of<Tab3Bloc>(context, listen: false).getTodoData();
              }),
          Divider(),
          TodoWidget(),
          RaisedButton(
              child: Text('Increase count'),
              onPressed: () {
                Provider.of<Tab3Bloc>(context, listen: false).increaseCount();
              }),
          CounterWidget(),
        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build TodoWidget');
    var bloc = Provider.of<Tab3Bloc>(context, listen: false);
    return StreamBuilder<bool>(
        stream: bloc.loadingStreamController.dataStream,
        initialData: false,
        builder: (context, snapshot) {
          var loading = snapshot.data;

          var value = 'No data';
          if (loading) {
            value = 'Loading...';
          } else {
            if (bloc.todoModel != null) {
              value = bloc.todoModel.toString();
            }
          }
          return Text(value);
        });
  }
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build CounterWidget');
    var bloc = Provider.of<Tab3Bloc>(context, listen: false);
    var blocTodo = Provider.of<Tab3Bloc>(context, listen: false);

    return StreamBuilder<int>(
        stream: bloc.countStreamController.dataStream,
        initialData: 0,
        builder: (context, snapshot) {
          print(snapshot);
          return Container(
              child: Column(
            children: <Widget>[
              Text('${snapshot.data}'),
              StreamBuilder<bool>(
                  stream: blocTodo.loadingStreamController.dataStream,
                  initialData: false,
                  builder: (context, snapshot) {
                    var loading = snapshot.data;

                    var value = 'No data';
                    if (loading) {
                      value = 'Loading...';
                    } else {
                      if (blocTodo.todoModel != null) {
                        value = blocTodo.todoModel.toString();
                      }
                    }
                    return Text(value);
                  })
            ],
          ));
        });
  }
}
