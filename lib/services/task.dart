import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b6_v2/models/task.dart';

class TaskServices {
  String task = "taskCollection";

  ///Create Task
  Future createTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .add(model.toJson());
  }

  ///Get All Tasks
  ///Get Completed Tasks
  ///Get InCompleted Tasks
  ///Update Task
  Future updateTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .doc(model.docId)
        .update({'title': model.title, 'description': model.description});
  }

  ///Delete Task
  Future deleteTask(String docID) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .doc(docID)
        .delete();
  }

  ///Mark Task as Complete
  Future markTaskAsComplete(String taskID) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .doc(taskID)
        .update({'isCompleted': true});
  }
}
