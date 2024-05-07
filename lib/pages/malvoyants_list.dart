import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_project/pages/add_malvoyant.dart';
import 'package:co_i_project/pages/malvoyant_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MalvoyantsList extends StatefulWidget {
  const MalvoyantsList({super.key}) ;

  @override
  State<MalvoyantsList> createState() => _MalvoyantsListState();
}

class _MalvoyantsListState extends State<MalvoyantsList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  // Fonction pour ajouter un malvoyant
  // ignore: unused_element
  Future<void> _addMalvoyant(String firstName, String lastName, String phoneNumber) async {
    try {
      await _firestore.collection('malvoyants').add({
        'first name': firstName,
        'last name': lastName,
        'phone number': phoneNumber,
        'userId':userId,

      });
    } catch (e) {
      // ignore: avoid_print
      print('Erreur lors de l\'ajout du malvoyant: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des malvoyants"),
        actions: [
           IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMalvoyantPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:_firestore.collection('malvoyants').where('userId', isEqualTo: userId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> malvoyantsList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: malvoyantsList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = malvoyantsList[index];                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String firstname = data['first name'];
                String lastname = data['last name'];
                String phoneNumber = data['phone number'];

                return ListTile(
                  title: Text('$firstname $lastname'),
                  subtitle: Text(phoneNumber),
                  // Actions à effectuer lors du tap sur un malvoyant
                  onTap: () {
                    // Implémentez ici l'action que vous souhaitez effectuer lors du tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                         MalvoyantDetailsPage(
                          docID: document.id,
                          firstName: firstname,
                          lastName: lastname, 
                          phoneNumber: phoneNumber,
                          ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Une erreur s'est produite : ${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}