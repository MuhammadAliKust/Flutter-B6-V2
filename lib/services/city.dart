import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b6_v2/models/city.dart';

class CityServices {
  String city = "cityCollection";

  ///Create City
  Future createCity(CityModel model) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(city).doc();
    return await FirebaseFirestore.instance
        .collection(city)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  ///Get All Countries
  Stream<List<CityModel>> getCitiesByCountryID(String countryID) {
    return FirebaseFirestore.instance
        .collection(city)
        .where('countryID', isEqualTo: countryID)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => CityModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Update City
  Future updateCity(CityModel model) async {
    return await FirebaseFirestore.instance
        .collection(city)
        .doc(model.docId)
        .update({'name': model.name});
  }

  ///Delete City
  Future deleteCity(String docID) async {
    return await FirebaseFirestore.instance
        .collection(city)
        .doc(docID)
        .delete();
  }
}
