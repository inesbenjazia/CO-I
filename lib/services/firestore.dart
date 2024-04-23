
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of notes 
  final CollectionReference persons = FirebaseFirestore.instance.collection('persons');

  //CREATE: add a new person
  Future<void> addPerson(String firstname, String lastname, String image, String relationship){
    return persons.add({
    'firstname': firstname,
    'lastname': lastname,
    'image': image,
    'relationship': relationship,
    'timestamp': Timestamp.now(),
    });
  }

  //READ : get persons from database
  Stream<QuerySnapshot> getPersonsStream() {
    final personsStream = 
      persons.orderBy('timestamp', descending: true).snapshots();

    return personsStream;
  }

  //update: update persons given a doc id 
  Future<void> updatePerson(String docID, String firstname, String lastname, String image, String relationship){
    return persons.doc(docID).update({
    'firstname': firstname,
    'lastname': lastname,
    'image': image,
    'relationship': relationship,
    'timestamp': Timestamp.now(),
    });
  }

  //DELETE: delete persons given a doc id 
  Future<void> deletePerson(String docID){
    return persons.doc(docID).delete();
  }
}