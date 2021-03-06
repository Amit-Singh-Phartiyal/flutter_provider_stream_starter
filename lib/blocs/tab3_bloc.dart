import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_provider_stream_starter/isolate_tasks/get_todo_task.dart';
import 'package:flutter_provider_stream_starter/isolate_tasks/worker/worker.dart';
import 'package:flutter_provider_stream_starter/models/todo_model.dart';

class Tab3Bloc {
  TodoModel todoModel;
  FlStreamController<bool> loadingStreamController = FlStreamController();
  FlStreamController<int> countStreamController = FlStreamController();
  int _count = 0;

  Future getTodoData() async {
    final dio = Dio();
    var todoTask = GetTodoTask(dio: dio, id: 1);
    final worker = Worker(poolSize: 2);
    loadingStreamController.setData(true);
    todoModel = (await worker.handle(todoTask)) as TodoModel;
    loadingStreamController.setData(false);
  }

  void increaseCount() {
    countStreamController.setData(_count++);
  }
}

class FlStreamController<T> {
  T _prevData;

  // Stream of data T to notify the T data change
  final StreamController<T> _dataController = StreamController.broadcast();

  Stream<T> get dataStream => _dataController.stream;

  void setData(T data) {
    if (_prevData != data) {
      _prevData = data;
      _dataController.add(data);
    }
  }
}
