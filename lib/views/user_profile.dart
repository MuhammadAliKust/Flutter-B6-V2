import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_v2/models/user.dart';
import 'package:flutter_b6_v2/services/user.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: StreamProvider.value(
        value:
            UserServices().getUserByID(FirebaseAuth.instance.currentUser!.uid),
        initialData: UserModel(),
        builder: (context, child) {
          UserModel userModel = context.watch<UserModel>();
          return Column(
            children: [
              Text(userModel.name.toString()),
              Text(userModel.phone.toString()),
              Text(userModel.email.toString()),
            ],
          );
        },
      ),
    );
  }
}
