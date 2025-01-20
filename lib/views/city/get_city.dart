import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_v2/models/city.dart';
import 'package:flutter_b6_v2/models/country.dart';
import 'package:flutter_b6_v2/models/task.dart';
import 'package:flutter_b6_v2/services/city.dart';
import 'package:flutter_b6_v2/services/country.dart';
import 'package:flutter_b6_v2/services/task.dart';
import 'package:flutter_b6_v2/views/city/create_city.dart';
import 'package:flutter_b6_v2/views/country/create_country.dart';
import 'package:flutter_b6_v2/views/country/update_country.dart';
import 'package:flutter_b6_v2/views/create_task.dart';
import 'package:flutter_b6_v2/views/update_task.dart';
import 'package:flutter_b6_v2/views/user_profile.dart';
import 'package:provider/provider.dart';

class GetAllCities extends StatelessWidget {
  CountryModel model;

  GetAllCities({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Cities"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateCityView()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: CityServices().getCitiesByCountryID(model.docId.toString()),
        initialData: [CityModel()],
        builder: (context, child) {
          List<CityModel> cityList = context.watch<List<CityModel>>();
          return ListView.builder(
              itemCount: cityList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Icon(Icons.map),
                  title: Text(cityList[i].name.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            // Navigator.push(
                                // context,
                                // MaterialPageRoute(
                                //     builder: (context) => UpdateCountryView(
                                //           model: countryList[i],
                                //         )));
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                        onPressed: () async {
                          try {
                            await CityServices()
                                .deleteCity(cityList[i].docId.toString());
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
