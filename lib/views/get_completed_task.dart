import 'package:flutter/material.dart';
import 'package:flutter_b6_v2/models/task.dart';
import 'package:flutter_b6_v2/services/task.dart';
import 'package:provider/provider.dart';

class GetCompletedTaskView extends StatelessWidget {
  const GetCompletedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Completed Task"),
      ),
      body: StreamProvider.value(
        value: TaskServices().getCompletedTask(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(taskList[i].title.toString()),
                  subtitle: Text(taskList[i].description.toString()),
                );
              });
        },
      ),
    );
  }
}
