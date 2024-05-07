import 'package:co_i_project/services/firestore.dart';
import 'package:flutter/material.dart';

class EditMalvoyantPage extends StatefulWidget {
  final String docID;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  const EditMalvoyantPage({
    super.key,
  required this.docID,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    });

  @override
  State<EditMalvoyantPage> createState() => _EditMalvoyantPageState();
}

class _EditMalvoyantPageState extends State<EditMalvoyantPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();

   @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.firstName;
    _lastNameController.text = widget.lastName;
    _phoneNumberController.text = widget.phoneNumber;
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Malvoyant ',
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
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
  // Récupérer les valeurs mises à jour des champs texte
  String updatedFirstName = _firstNameController.text;
  String updatedLastName = _lastNameController.text;
  String updatedPhoneNumber = _phoneNumberController.text;
  
  // Appeler la fonction pour mettre à jour les détails de la personne
  firestoreService.updateMalvoyant(
    widget.docID,
    updatedFirstName,
    updatedLastName,
    updatedPhoneNumber
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