import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_v2/models/city.dart';
import 'package:flutter_b6_v2/models/country.dart';
import 'package:flutter_b6_v2/models/task.dart';
import 'package:flutter_b6_v2/services/city.dart';
import 'package:flutter_b6_v2/services/country.dart';
import 'package:flutter_b6_v2/services/task.dart';

class CreateCityView extends StatefulWidget {
  CreateCityView({super.key});

  @override
  State<CreateCityView> createState() => _CreateCityViewState();
}

class _CreateCityViewState extends State<CreateCityView> {
  TextEditingController nameController = TextEditingController();

  bool isLoading = false;

  List<CountryModel> countryList = [];
  CountryModel? _selectedCountry;

  @override
  void initState() {
    CountryServices().getAllCountries().first.then((val) {
      countryList = val;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create City"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButton(
              items: countryList.map((country) {
                return DropdownMenuItem(
                  child: Text(country.name.toString()),
                  value: country,
                );
              }).toList(),
              value: _selectedCountry,
              isExpanded: true,
              hint: Text("Select Country"),
              onChanged: (val) {
                _selectedCountry = val;
                setState(() {});
              }),
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
                      await CityServices()
                          .createCity(CityModel(
                              countryId: _selectedCountry!.docId.toString(),
                              name: nameController.text,
                              createdAt: DateTime.now().millisecondsSinceEpoch))
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content:
                                    Text("City has been created successfully"),
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
                  child: Text("Create City"))
        ],
      ),
    );
  }
}
