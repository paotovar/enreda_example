import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];

  QuerySnapshot querySnapshot = await db.collection('people').get();

  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      "name": data['name'],
      "uid": doc.id,
    };

    people.add(person);
  }

  return people;
}

Future<void> addPeople(String name) async {
  await db.collection("people").add({"name": name});
}

Future<void> updatePeople(String uid, String newName) async {
  await db.collection("people").doc(uid).set({"name": newName});
}

Future<void> deletePeople(String uid) async {
  await db.collection("people").doc(uid).delete();
}
