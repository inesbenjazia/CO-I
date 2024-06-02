import 'package:co_i_project/pages/edit_account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountInformationsPage extends StatefulWidget {

  const AccountInformationsPage({super.key});

  @override
  State<AccountInformationsPage> createState() => _AccountInformationsPageState();
}

class _AccountInformationsPageState extends State<AccountInformationsPage> {
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AccountInformationsPage(),
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                size: 20.0,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'ACCOUNT DETAILS',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditAccountPage(),
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.settings,
                                size: 20.0,
                               
                              ),
                              SizedBox(width: 8),
                              Text(
                                'EDIT',
                                style: TextStyle(
                                  fontSize: 17,
                                  
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}