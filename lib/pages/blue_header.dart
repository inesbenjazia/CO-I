import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_project/pages/account_informations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BlueHeader extends StatelessWidget {
  

  BlueHeader({
    super.key,
   
  });
      final user = FirebaseAuth.instance.currentUser!.email;
     final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 170, // Hauteur de l'en-tête
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(21, 137, 179, 1), // Couleur foncée en haut
                       Color.fromRGBO(136, 222, 254, 1), // Couleur claire en bas
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight:Radius.circular(30),
                      bottomLeft:Radius.circular(30),
                    ),
                   ),

                  
                    
                        child: Stack(
                          children:[ 
                            Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 28.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Welcome',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              
                                
                              Padding(
                                padding: const EdgeInsets.only(left: 2.5),
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: _firestore.collection('users').where('email', isEqualTo: user).snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Erreur: ${snapshot.error}');
                                    }
                              
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Text('Chargement...');
                                    }
                              
                                    if (snapshot.data!.docs.isEmpty) {
                                      return const Text('Aucun utilisateur trouvé.');
                                    }
                              
                                    // Si l'utilisateur est trouvé, accédez à ses données
                                    String firstName = snapshot.data!.docs[0]['first name'];
                                    String lastName = snapshot.data!.docs[0]['last name'];
                              
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                         '$firstName $lastName',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                               
                            ],
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 27.0),
                            child: Align(
                                
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  const AccountInformationsPage()),);
                                  },
                                  color: Colors.white,
                                  iconSize: 34,
                                  icon: const Icon(Icons.account_circle), // Utilisation de l'icône de compte utilisateur
                                ),
                              ),
                          ),
                          ],
                        ),                  
                );
               
  }
}