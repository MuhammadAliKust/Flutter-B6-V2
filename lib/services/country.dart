import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b6_v2/models/country.dart';

class CountryServices {
  String country = "countryCollection";

  ///Create Country
  Future createCountry(CountryModel model) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(country).doc();
    return await FirebaseFirestore.instance
        .collection(country)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  ///Get All Countries
  Stream<List<CountryModel>> getAllCountries() {
    return FirebaseFirestore.instance.collection(country).snapshots().map(
        (taskList) => taskList.docs
            .map((taskModel) => CountryModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Update Country
  Future updateCountry(CountryModel model) async {
    return await FirebaseFirestore.instance
        .collection(country)
        .doc(model.docId)
        .update({'name': model.name});
  }

  ///Delete Country
  Future deleteCountry(String docID) async {
    return await FirebaseFirestore.instance
        .collection(country)
        .doc(docID)
        .delete();
  }
}
