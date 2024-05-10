import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_project/pages/add_person_page.dart';
import 'package:co_i_project/pages/card.dart';
import 'package:co_i_project/pages/malvoyants_list.dart';
import 'package:co_i_project/pages/person_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonsListPage extends StatefulWidget {
  final String malvoyantId;

  const PersonsListPage({super.key, required this.malvoyantId});

  @override
  State<PersonsListPage> createState() => _PersonsListPageState();
}

class _PersonsListPageState extends State<PersonsListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personnes"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.login),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MalvoyantsList()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPersonPage(
                malvoyantId: widget.malvoyantId,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('persons').where('malvoyantId', isEqualTo: widget.malvoyantId).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List personsList = snapshot.data!.docs;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 36.0,
                ),
                itemCount: personsList.length + 1,
                itemBuilder: (context, index) {
                  if (index == personsList.length) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPersonPage(
                              malvoyantId: widget.malvoyantId,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 48.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  } else {
                    DocumentSnapshot document = personsList[index];
                    String docID = document.id;
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    String firstname = data['firstname'];
                    String lastname = data['lastname'];
                    String image = data['image'];
                    String relationship = data['relationship'];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonDetailsPage(
                              docID: docID,
                              firstName: firstname,
                              lastName: lastname,
                              imageUrl: image,
                              relationship: relationship,
                            ),
                          ),
                        );
                      },
                      child: CustomCard(
                        title: '$firstname $lastname',
                        subtitle: relationship,
                        imageUrl: image,
                      ),
                    );
                  }
                },
              );
            } else if (snapshot.hasError) {
              return const Text("No persons..!");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}