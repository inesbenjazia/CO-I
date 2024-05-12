
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // get collection of persons 
  final CollectionReference persons = FirebaseFirestore.instance.collection('persons');
  final CollectionReference malvoyants = FirebaseFirestore.instance.collection('malvoyants');
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // CREATE: Ajouter un malvoyant
  Future<DocumentReference> addMalvoyant(String firstName, String lastName, String phoneNumber , String userId) async {
    return await malvoyants.add({
      'first name': firstName,
      'last name': lastName,
      'phone number': phoneNumber,
      'userId': userId,

    });
  }

  // READ: Obtenir tous les malvoyants
  Stream<QuerySnapshot> getMalvoyantsStream() {
    return malvoyants.snapshots();
  }

   // UPDATE: Mettre à jour les informations d'un malvoyant
  Future<void> updateMalvoyant(String malvoyantId, String firstName, String lastName, String phoneNumber) async {
    await malvoyants.doc(malvoyantId).update({
      'first name': firstName,
      'last name': lastName,
      'phone number': phoneNumber,
    });
  }

  //DELETE: supprimer un malvoyant 
   Future<void> deleteMalvoyant(String malvoyantId) async {
    await malvoyants.doc(malvoyantId).delete();
  }

  
  // Méthode pour ajouter une personne à un malvoyant spécifique
  Future<void> addPersonToMalvoyant( String firstname, String lastname, String image, String relationship,String malvoyantId) async {
    // Ajouter la personne avec un champ 'malvoyantId' indiquant le malvoyant auquel elle est associée
    await persons.add({
      'firstname': firstname,
      'lastname': lastname,
      'image': image,
      'relationship': relationship,
      'malvoyantId': malvoyantId, // Champ indiquant le malvoyant associé
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
  Future<void> updatePerson(String docID, String? firstname, String? lastname, String? image, String? relationship) async {
  // ignore: unused_local_variable
  final DocumentSnapshot doc = await persons.doc(docID).get();

  final Map<String, dynamic> updatedData = {};

  if (firstname != null && firstname.isNotEmpty) {
    updatedData['firstname'] = firstname;
  }

  if (lastname != null && lastname.isNotEmpty) {
    updatedData['lastname'] = lastname;
  }

  if (image != null && image.isNotEmpty) {
    updatedData['image'] = image;
  }

  if (relationship != null && relationship.isNotEmpty) {
    updatedData['relationship'] = relationship;
  }

  updatedData['timestamp'] = Timestamp.now();

  return persons.doc(docID).update(updatedData);
}


  //DELETE: delete persons given a doc id 
  Future<void> deletePerson(String docID){
    return persons.doc(docID).delete();
  }

  // SEARCH: Search for persons based on specific criteria
Future<List<DocumentSnapshot>> searchPersons(String searchTerm) async {
  final QuerySnapshot querySnapshot = await persons.where('firstname', isEqualTo: searchTerm).get();

  return querySnapshot.docs;
}
}

