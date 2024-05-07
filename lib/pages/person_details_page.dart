import 'package:co_i_project/pages/edit_page.dart';
import 'package:co_i_project/services/firestore.dart';
import 'package:flutter/material.dart';

class PersonDetailsPage extends StatelessWidget {
  final String docID;
  final String firstName;
  final String lastName;
  final String relationship;
  final String imageUrl;

  final FirestoreService firestoreService = FirestoreService();
   PersonDetailsPage({
    super.key, 
    required this.docID,
    required this.firstName,
    required this.lastName,
    required this.relationship,
    required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // Fetch person details using docID from Firestore or any other method
    // For demonstration purposes, I'm just displaying the docID here
    return 
    Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), 
        child: AppBar(
          title: const Text( "Person details",
          style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
        ),
        
        backgroundColor: Colors.blue,
        centerTitle: true,

        
        ),
        
      ),
      body: SafeArea(
    child: Stack(
      children: [
        Positioned(
          top: 0, // Adjust as needed
          left: 0, // Adjust as needed
          right: 0, // Adjust as needed
          height: 360, // Adjust as needed
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200),
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
                  'Relationship: $relationship',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
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
          relationship: relationship,
        ),
      ),
    );
  },
  icon: const Icon(Icons.settings),
),
IconButton(
  onPressed: () {
    // Supprimer la personne
    firestoreService.deletePerson(docID);
    // Retourner à la HomePage
    Navigator.pop(context);
  },
  icon: const Icon(Icons.delete),
),

                // Add more widgets to display other details of the person
              ],
            ),
          ),
        ),
      ],
    ),
  ),
    );
    
  }
}
