import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_project/pages/person_details_page.dart';
import 'package:co_i_project/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();

  //text controller
  final TextEditingController textControllerFirstname = TextEditingController();
  final TextEditingController textControllerLastname = TextEditingController();
  final TextEditingController textControllerImage = TextEditingController();
  final TextEditingController textControllerRelationship = TextEditingController();

  
  //open a dialog box to add a person
  void openPersonBox({String? docID}){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
          controller: textControllerFirstname,
          decoration: const InputDecoration(labelText: 'Firstname')
      ) ,
      TextField(
            controller: textControllerLastname,
            decoration: const InputDecoration(labelText: 'Lastname'),
          ),
          TextField(
            controller: textControllerImage,
            decoration: const InputDecoration(labelText: 'Image'),
          ),
          TextField(
            controller: textControllerRelationship,
            decoration: const InputDecoration(labelText: 'Relationship'),
          ),
        ],
      ),
       
      actions: [
        //button to save 
        ElevatedButton(
          onPressed: () {
            //add a new person
            if (docID == null){
              firestoreService.addPerson(textControllerFirstname.text,
                textControllerLastname.text,
                textControllerImage.text,
                textControllerRelationship.text);
            }

            //update an existing person
            else{
              firestoreService.updatePerson(docID,
                textControllerFirstname.text,
                textControllerLastname.text,
                textControllerImage.text,
                textControllerRelationship.text);
            }
            
            //clear the text controller
            textControllerFirstname.clear();
            textControllerLastname.clear();
            textControllerImage.clear();
            textControllerRelationship.clear();

            //close the box
            Navigator.pop(context);
          }, 
          child: const Text("Add"),
          )
      ],
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personnes")),
      floatingActionButton: FloatingActionButton(
        onPressed: openPersonBox,
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //update button
                      IconButton(
                       onPressed: () => openPersonBox(docID: docID),
                        icon: const Icon(Icons.settings),
                      ), 

                      //delete button
                      IconButton(
                    onPressed: () => firestoreService.deletePerson(docID),
                    icon: const Icon(Icons.delete),
                  ), 
                    ],
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