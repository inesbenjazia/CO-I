import 'package:co_i_project/pages/edit_page.dart';
import 'package:co_i_project/services/firestore.dart';
import 'package:flutter/material.dart';

class MalvoyantDetailsPage extends StatelessWidget {
  final String docID;
  final String firstName;
  final String lastName;
  final String condition;
  final String imageUrl;

  final FirestoreService firestoreService = FirestoreService();

  MalvoyantDetailsPage({
    super.key, 
    required this.docID,
    required this.firstName,
    required this.lastName,
    required this.condition,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Malvoyant Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -20,
            left: 0,
            right: 0,
            height: 250,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Name: $firstName $lastName',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Condition: $condition',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPersonPage(
                            docID: docID,
                            firstName: firstName,
                            lastName: lastName,
                            imageUrl: imageUrl,
                            relationship: condition,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.settings),
                  ),
                  IconButton(
                    onPressed: () {
                      // Supprimer le malvoyant
                      firestoreService.deletePerson(docID);
                      // Retourner à la page précédente
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}