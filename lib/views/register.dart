import 'package:flutter/material.dart';
import 'package:flutter_b6_v2/models/user.dart';
import 'package:flutter_b6_v2/services/auth.dart';
import 'package:flutter_b6_v2/services/user.dart';
import 'package:flutter_b6_v2/views/login.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(label: Text("Name")),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(label: Text("Phone")),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(label: Text("Address")),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(label: Text("Email")),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: pwdController,
            decoration: InputDecoration(label: Text("Password")),
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
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Email cannot be empty.")));
                      return;
                    }
                    if (pwdController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Password cannot be empty.")));
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await AuthServices()
                          .signUpUser(
                              email: emailController.text,
                              password: pwdController.text)
                          .then((val) async {
                        await UserServices()
                            .createUser(UserModel(
                                docId: val!.uid.toString(),
                                email: emailController.text,
                                address: addressController.text,
                                name: nameController.text,
                                phone: phoneController.text))
                            .then((val) {
                          isLoading = false;
                          setState(() {});
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text("User registered Successfully"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginView()));
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
                  child: Text("Register")),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
