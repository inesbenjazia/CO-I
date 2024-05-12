import 'package:co_i_project/pages/blue_header.dart';
import 'package:co_i_project/pages/edit_malvoyant_page.dart';
import 'package:co_i_project/pages/personlistpagewithpadding.dart';
import 'package:co_i_project/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1.0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BlueHeader(
              userEmail: FirebaseAuth.instance.currentUser!.email!,
            ),
            const SizedBox(height: 20), // Added space
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                
                child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'First Name :',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color : Color.fromRGBO(46, 160, 201, 1),
                                    ),
                                  ),
                                  Text(
                                    'Last Name :',
                                     style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color : Color.fromRGBO(46, 160, 201, 1),
                                    ),
                                  ),
                                  Text(
                                    'Phone Number :',
                                     style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color : Color.fromRGBO(46, 160, 201, 1),
                                    ),
                                  ),
                                  
                                
                                ],
                              ),
                             Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                  firstName,
                                  style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(54, 48, 48, 0.898),
                                  ),
                                 ),
                                  Text(
                                lastName ,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(54, 48, 48, 0.898),

                                  ),
                                 ),
                                 Text(
                                phoneNumber,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(54, 48, 48, 0.898),
                                ),
                              ),
                                  
                               ],
                             ),
                            ],
                
                          ),
                          const SizedBox(height: 10,),  
                          
                        ],
                      ),
                    ),
              ),
            ),
            // Buttons section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditMalvoyantPage(
                            docID: docID,
                            firstName: firstName,
                            lastName: lastName,
                            phoneNumber: phoneNumber,
                          ),
                                    ),
                                  );
                                },
                                icon: Image.asset(
                                  'lib/images/pen.png', // Remplacer 'your_image.png' par le nom de votre image
                                  height: 40, // Ajouter la hauteur souhaitée
                                  width: 40, // Ajouter la largeur souhaitée
                                ),
                              ),
                              const SizedBox(width: 80),
                  IconButton(
                                onPressed: () {
                                  // Supprimer la personne
                                  firestoreService.deleteMalvoyant(docID);
                                  // Retourner à la HomePage
                                  Navigator.pop(context);
                                },
                                icon: Image.asset(
                                  'lib/images/delete.png', // Remplacer 'your_image.png' par le nom de votre image
                                  height: 40, // Ajouter la hauteur souhaitée
                                  width: 40, // Ajouter la largeur souhaitée
                                ),
                              ),
                  
                 // const SizedBox(width: 10),
                  
                ],
              ),
            ),
           
            const SizedBox(height: 40), 
            Center(
              child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonsListPage(malvoyantId: docID),
                          ),
                        );
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  const Color.fromRGBO(21, 137, 179, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                   ),
                      child: const Text('Voir les personnes associées',
                      style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                    ),
            )// Added space
          ],
        ),
      ),
    );
  }
}
