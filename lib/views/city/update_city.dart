import 'package:flutter/material.dart';
import 'package:flutter_b6_v2/models/country.dart';
import 'package:flutter_b6_v2/models/task.dart';
import 'package:flutter_b6_v2/services/country.dart';
import 'package:flutter_b6_v2/services/task.dart';

class UpdateCountryView extends StatefulWidget {
  final CountryModel model;

  UpdateCountryView({super.key, required this.model});

  @override
  State<UpdateCountryView> createState() => _UpdateCountryViewState();
}

class _UpdateCountryViewState extends State<UpdateCountryView> {
  TextEditingController nameController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.model.name.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Country"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
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
                    if (nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Name cannot be empty.")));
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await CountryServices()
                          .updateCountry(CountryModel(
                              docId: widget.model.docId.toString(),
                              name: nameController.text))
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content:
                                    Text("Country has been updated successfully"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Okay"))
                                ],
                              );
                            });
                      });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Update Country"))
        ],
      ),
    );
  }
}
