import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser!.email;

  

  Future<DocumentSnapshot> getUserData() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: user)
        .get();
    return querySnapshot.docs.first;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
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
                                    String sexe = snapshot.data!.docs[0]['sexe'];
                                    String email = snapshot.data!.docs[0]['email'];
                                    String phoneNumber = snapshot.data!.docs[0]['phone number'].toString();
                                                                  
                                    return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text('First Name'),
                    subtitle: Text(firstName),
                  ),
                  ListTile(
                    title: const Text('Last Name'),
                    subtitle: Text(lastName),
                  ),
                  ListTile(
                    title: const Text('Phone Number'),
                    subtitle: Text(phoneNumber),
                  ),
                  ListTile(
                    title: const Text('Sexe'),
                    subtitle: Text(sexe),
                  ),
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(email),
                  ),
                  // Add your form fields here for editing
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}