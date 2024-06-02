import 'package:co_i_project/pages/blue_header.dart';
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
  backgroundColor: const Color.fromRGBO(243, 243, 243, 1.0),
  body: SingleChildScrollView(
    
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Header
            BlueHeader(
              
            ),
        


        // formulaire 
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 5),
              const Text(
                ' Add Malyovant',
                style: TextStyle(
                 fontSize: 18,
                 fontWeight: FontWeight.w500,
                 color: Color.fromRGBO(54, 48, 48, 0.898),
                ),
                ),
                const SizedBox(height: 10),
              
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(106, 198, 232, 1),),),
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
              ElevatedButton(
                onPressed: () {
                  // Récupérer les valeurs des champs texte
                  String firstName = _firstNameController.text;
                  String lastName = _lastNameController.text;
                  String phoneNumber = _phoneNumberController.text;
              
                  // Ajouter un nouveau malvoyant avec les données fournies
                  firestoreService.addMalvoyant(
                    firstName,
                    lastName,
                    phoneNumber,
                   // sexe,
                    userId,
                  );
              
                  // Effacer les champs texte après l'ajout
                  _firstNameController.clear();
                  _lastNameController.clear();
                  _phoneNumberController.clear();
              
                  // Naviguer vers l'écran précédent
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(106, 198, 232, 1), // Couleur de fond
                  side: const BorderSide(color: Colors.white), // Bordure autour du bouton
                  
                ),
                child: const Text(
                  'Add Malvoyant',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),


            ],
          ),
        ),
      ],
    ),
  ),
);

  }
}