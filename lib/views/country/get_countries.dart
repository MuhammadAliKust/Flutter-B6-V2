import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b6_v2/models/country.dart';
import 'package:flutter_b6_v2/models/task.dart';
import 'package:flutter_b6_v2/services/country.dart';
import 'package:flutter_b6_v2/services/task.dart';
import 'package:flutter_b6_v2/views/city/get_city.dart';
import 'package:flutter_b6_v2/views/country/create_country.dart';
import 'package:flutter_b6_v2/views/country/update_country.dart';
import 'package:flutter_b6_v2/views/create_task.dart';
import 'package:flutter_b6_v2/views/update_task.dart';
import 'package:flutter_b6_v2/views/user_profile.dart';
import 'package:provider/provider.dart';

class GetAllCountries extends StatelessWidget {
  const GetAllCountries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Countries"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateCountryView()));
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: CountryServices().getAllCountries(),
        initialData: [CountryModel()],
        builder: (context, child) {
          List<CountryModel> countryList = context.watch<List<CountryModel>>();
          return ListView.builder(
              itemCount: countryList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Icon(Icons.map),
                  title: Text(countryList[i].name.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateCountryView(
                                          model: countryList[i],
                                        )));
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                        onPressed: () async {
                          try {
                            await CountryServices()
                                .deleteCountry(countryList[i].docId.toString());
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
                      IconButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GetAllCities(model: countryList[i])));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
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
