import 'package:co_i_project/services/firestore.dart';
import 'package:flutter/material.dart';

class EditPersonPage extends StatefulWidget {
  //const EditPersonPage({super.key});

  final String docID;
  final String firstName;
  final String lastName;
  final String relationship;
  final String imageUrl;
  const EditPersonPage({
    super.key,
    required this.docID,
    required this.firstName,
    required this.lastName,
    required this.relationship,
    required this.imageUrl,
  });

  @override
  State<EditPersonPage> createState() => _EditPersonPageState();
}

class _EditPersonPageState extends State<EditPersonPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.firstName;
    _lastNameController.text = widget.lastName;
    _imageUrlController.text = widget.imageUrl;
    _relationshipController.text = widget.relationship;
  }
  
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Person',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _relationshipController,
              decoration: const InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
  // Récupérer les valeurs mises à jour des champs texte
  String updatedFirstName = _firstNameController.text;
  String updatedLastName = _lastNameController.text;
  String updatedImageUrl = _imageUrlController.text;
  String updatedRelationship = _relationshipController.text;

  // Appeler la fonction pour mettre à jour les détails de la personne
  firestoreService.updatePerson(
    widget.docID,
    updatedFirstName,
    updatedLastName,
    updatedImageUrl,
    updatedRelationship,
  );

  // Naviguer vers l'écran précédent après la mise à jour
  Navigator.pop(context);
},

              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}