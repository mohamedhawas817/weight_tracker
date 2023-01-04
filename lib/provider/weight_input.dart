import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weight.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';


class WeightInput with ChangeNotifier {

  var uuid = Uuid();


  List<Weight> _weights = [];
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  final fireStore = FirebaseFirestore.instance;

  List<Weight> get weights {
    return _weights;

  }

  Future<void> getList() async {
    try {
      final weightSnapshot = await fireStore.collection("weights").orderBy('dateTime', descending: true).get();
      final data = weightSnapshot.docs.where((element) => element['uid'] == userUid);
      List<Weight> loadedWeights = [];
      data.map((e) {
        loadedWeights.add(Weight(e['id'], e['weight'], e['dateTime'].toDate()));
      }).toList();
      _weights = loadedWeights;
      notifyListeners();



    }catch(e) {
      print(e);
    }
  }



  Future<void> add_list(weight) async {
     _weights.add(Weight(uuid.v1(), weight, DateTime.now()));
     notifyListeners();
     try {
       await fireStore.collection('weights').add({
         'weight': weight,
      'dateTime' : DateTime.now(),
      'id': uuid.v1(),
         "uid": userUid
       });
     }catch(e) {
        print(e);
     }
  }

  Future<void> deleteweight(id) async {
    _weights.removeWhere((element) => element.id == id);
    notifyListeners();
    try {

      final weightdata =await fireStore.collection('weights').get();
      final data = weightdata.docs.where((element) => element['id'] ==id );
      final doucmentId = data.first.id;
      await fireStore.collection("weights").doc(doucmentId).delete();

    }catch(e){
      print(e);
    }
  }


  Future<void> editweight(id, weight) async {
    final index = _weights.indexWhere((element) => element.id == id);
    _weights[index] = Weight(uuid.v1(), weight, DateTime.now());
    notifyListeners();

    try {

     final weightData = await fireStore.collection('weights').get();
     final data =  weightData.docs.firstWhere((element) => element['id'] == id);
      fireStore.collection("weights").doc(data.id).update({
       'weight': weight
     });


   }catch(e) {
     print(e);
   }


  }



}



