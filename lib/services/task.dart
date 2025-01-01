import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b6_v2/models/task.dart';

class TaskServices {
  String task = "taskCollection";

  ///Create Task
  Future createTask(TaskModel model) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(task).doc();
    return await FirebaseFirestore.instance
        .collection(task)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  ///Get All Tasks
  Stream<List<TaskModel>> getAllTask() {
    return FirebaseFirestore.instance
        .collection(task)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Get Completed Tasks
  Stream<List<TaskModel>> getCompletedTask() {
    return FirebaseFirestore.instance
        .collection(task)
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Get InCompleted Tasks
  Stream<List<TaskModel>> getInCompletedTask() {
    return FirebaseFirestore.instance
        .collection(task)
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

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
  Future markTaskAsComplete(String taskID, bool status) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .doc(taskID)
        .update({'isCompleted': status});
  }
}
