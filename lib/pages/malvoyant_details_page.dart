import 'package:co_i_project/pages/edit_malvoyant_page.dart';
import 'package:co_i_project/pages/persons_list_page.dart';
//import 'package:co_i_project/pages/edit_page.dart';
import 'package:co_i_project/services/firestore.dart';
import 'package:flutter/material.dart';

class MalvoyantDetailsPage extends StatelessWidget {
  final String docID;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  final FirestoreService firestoreService = FirestoreService();

  MalvoyantDetailsPage({
    super.key, 
    required this.docID,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditMalvoyantPage(
                            docID: docID,
                            firstName: firstName,
                            lastName: lastName,
                            phoneNumber: phoneNumber
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.settings),
                  ),
                  IconButton(
                    onPressed: () {
                      // Supprimer le malvoyant
                      firestoreService.deleteMalvoyant(docID);
                      // Retourner à la page précédente
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => PersonsListPage(malvoyantId: docID)),
                      );
                    }, 
                    child: const Text('Voir les personnes associées'),
                )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}