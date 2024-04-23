import 'package:flutter/material.dart';

class PersonDetailsPage extends StatelessWidget {
  final String docID;
  final String firstName;
  final String lastName;
  final String relationship;
  final String imageUrl;


  const PersonDetailsPage({
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), 
        child: AppBar(
          title: const Text('Welcome',
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
      body: Stack(
        children: [
          Positioned(
            top: -20, // Adjust as needed
            left: 0, // Adjust as needed
            right: 0, // Adjust as needed
            height: 250, // Adjust as needed
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
             'Relationship: $relationship',
              style: const TextStyle(
                fontSize: 18,
              ),
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
