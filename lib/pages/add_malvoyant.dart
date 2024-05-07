import 'package:co_i_project/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddMalvoyantPage extends StatefulWidget {
  const AddMalvoyantPage({super.key}) ;

  @override
  State<AddMalvoyantPage> createState() => _AddMalvoyantPageState();
}

class _AddMalvoyantPageState extends State<AddMalvoyantPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();


  final FirestoreService firestoreService = FirestoreService();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Malvoyant',
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
                labelText: 'Phone number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Récupérer les valeurs des champs texte
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String phoneNumber = _phoneNumberController.text;
                

                // Ajouter une nouvelle personne avec les données fournies
                firestoreService.addMalvoyant(
                  firstName,
                  lastName,
                  phoneNumber,
                  userId,
                );

                // Effacer les champs texte après l'ajout
                _firstNameController.clear();
                _lastNameController.clear();
                _phoneNumberController.clear();
                

                // Naviguer vers l'écran précédent
                Navigator.pop(context);
              },
              child: const Text('Add Person'),
            ),
          ],
        ),
      ),
    );
  }
}