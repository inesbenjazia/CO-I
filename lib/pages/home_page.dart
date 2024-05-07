import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_project/pages/add_person_page.dart';

//import 'package:co_i_project/pages/edit_page.dart';

import 'package:co_i_project/pages/malvoyants_list.dart';
import 'package:co_i_project/pages/person_details_page.dart';
import 'package:co_i_project/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();
  final user = FirebaseAuth.instance.currentUser!;
  //text controller
  final TextEditingController textControllerFirstname = TextEditingController();
  final TextEditingController textControllerLastname = TextEditingController();
  final TextEditingController textControllerImage = TextEditingController();
  final TextEditingController textControllerRelationship = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personnes"),
      actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.login),
          ),
           IconButton(
             onPressed: () {
          // Naviguer vers la page AddPersonPage lorsqu'on appuie sur le bouton "Add"
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MalvoyantsList (),
          ));
        },
            icon: const Icon(Icons.settings),
          ),

      ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers la page AddPersonPage lorsqu'on appuie sur le bouton "Add"
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPersonPage (),
          ));
        },

        child: const Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getPersonsStream(),
          builder: (context,snapshot){
           //if we have data, get all the docs
           if (snapshot.hasData) {
            List personsList = snapshot.data!.docs;

            //display as a List
            return ListView.builder(
              itemCount: personsList.length,
              itemBuilder: (context,index) {
                //get each individual doc
                DocumentSnapshot document = personsList[index];
                String docID = document.id;
                
                //get person from each doc
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String firstname = data['firstname'];
                String lastname = data['lastname'];
                String image = data['image']; // Assuming image is a URL
                String relationship = data['relationship'];


                //display as list tile
                return GestureDetector(
                  onTap: () {
                    // Navigate to details page when tapped
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => PersonDetailsPage(docID: docID,
                    firstName: firstname,
                    lastName: lastname,
                    imageUrl: image,
                    relationship: relationship
                    ),
                    ),
                    );
                  },
                  child:
                  ListTile(
                  title: Text('$firstname $lastname'),
                  subtitle: Text(relationship),
                  leading: CircleAvatar(
                  backgroundImage: NetworkImage(image), // Assuming image is a URL
            ),
                  

                ) ,
                );
              },
              );
           }
           //if there is no data return nothing
           else{
            return const Text("No persons..!");
           }
          },
        ),
    );
  }
}