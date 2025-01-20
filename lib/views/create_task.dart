import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_v2/models/task.dart';
import 'package:flutter_b6_v2/services/task.dart';
import 'package:flutter_b6_v2/services/upload_file_services.dart';
import 'package:image_picker/image_picker.dart';

class CreateTaskView extends StatefulWidget {
  CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Column(
        children: [
          if (image != null)
            Image.file(
              image!,
              height: 200,
            ),
          ElevatedButton(
              onPressed: () {
                ImagePicker().pickImage(source: ImageSource.camera).then((val) {
                  image = File(val!.path);
                  setState(() {});
                });
              },
              child: Text("Pick Image")),
          TextField(
            controller: titleController,
          ),
          TextField(
            controller: descriptionController,
          ),
          SizedBox(
            height: 20,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Title cannot be empty.")));
                      return;
                    }
                    if (descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Description cannot be empty.")));
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await UploadFileServices()
                          .getUrl(image)
                          .then((downloadUrl) async {
                        await TaskServices()
                            .createTask(TaskModel(
                                title: titleController.text,
                                description: descriptionController.text,
                                isCompleted: false,
                                userID: FirebaseAuth.instance.currentUser!.uid,
                                image: downloadUrl,
                                createdAt:
                                    DateTime.now().millisecondsSinceEpoch))
                            .then((val) {
                          isLoading = false;
                          setState(() {});
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                      "Task has been created successfully"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          titleController.clear();
                                          descriptionController.clear();
                                          Navigator.pop(context);
                                        },
                                        child: Text("Okay"))
                                  ],
                                );
                              });
                        });
                      });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Create Task"))
        ],
      ),
    );
  }
}
