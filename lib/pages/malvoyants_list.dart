import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_project/pages/account_informations.dart';
import 'package:co_i_project/pages/malvoyant_details_page.dart';

import 'package:co_i_project/pages/upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MalvoyantsList extends StatefulWidget {
  const MalvoyantsList({super.key}) ;

  @override
  State<MalvoyantsList> createState() => _MalvoyantsListState();
}

class _MalvoyantsListState extends State<MalvoyantsList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser!.email;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1.0),
     
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UploadImage()),
          );
        },
        label: const Text(
          '+',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color : Color.fromRGBO(255, 255, 255, 1),
          ),
        ), // Texte du bouton
        backgroundColor: const Color.fromRGBO(106, 198, 232, 1), // Couleur du bouton
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Forme arrondie du bouton
          side: const BorderSide(color: Colors.white), // Bordure blanche autour du bouton
        ),
      ),

      
      body: 
         Column(
          children: [
            //Header
            Container(
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
                              IconButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                      },
                                      icon: const Icon(Icons.login),
                                    ),
                               
                            ],
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 27.0),
                            child: Align(
                                
                                alignment: Alignment.topRight,
                                child: IconButton(
                                onPressed: () {
                                  // Navigate to details page when tapped
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) =>   const AccountInformationsPage()                    ),
                                  );
                                },
                                color: Colors.white,
                                iconSize: 34,
                                icon: const Icon(Icons.account_circle), // Utilisation de l'icône de compte utilisateur
                                ),
                              ),
                            ),
                          ],
                        ),                        
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:_firestore.collection('malvoyants').where('userId', isEqualTo: userId).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> malvoyantsList = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: malvoyantsList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = malvoyantsList[index];
                        String docID = document.id;
              
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String firstname = data['first name'];
                        String lastname = data['last name'];
                        String phoneNumber = data['phone number'];
              
                        return ListTile(
                          title: Text('$firstname $lastname'),
                          subtitle: Text(phoneNumber),
                          // Actions à effectuer lors du tap sur un malvoyant
                          onTap: () {
                            
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => MalvoyantDetailsPage(docID: docID,
                            firstName: firstname,
                            lastName: lastname, 
                            phoneNumber: phoneNumber,
                            
                            ),
                            ),
                            );
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Une erreur s'est produite : ${snapshot.error}");
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              
            ),
          ],
        
      ),
      
    );
  }
}