import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_i_project/pages/add_person_page.dart';
import 'package:co_i_project/pages/card.dart';
import 'package:co_i_project/pages/person_details_page.dart';
import 'package:co_i_project/services/firestore.dart';
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
  final TextEditingController _searchController = TextEditingController();
  late List<DocumentSnapshot> searchResults = [];
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Blue header with search box
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200, // Header height
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(21, 137, 179, 1), // Dark color at the top
                  Color.fromRGBO(136, 222, 254, 1), // Light color at the bottom
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${user.email}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular((8.0)),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.search_rounded,
                          color: Color.fromRGBO(21, 137, 179, 1),
                        ),
                        onPressed: () async {
                          String searchTerm = _searchController.text.trim();
                          if (searchTerm.isNotEmpty) {
                            searchResults = await _firestoreService.searchPersons(searchTerm); // Call searchPersons from FirestoreService
                          } else {
                            searchResults = [];
                          }
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Added space
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Persons List',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _searchController.text.isEmpty
                        ? _firestore.collection('persons').where('malvoyantId', isEqualTo: widget.malvoyantId).snapshots()
                        : _firestore.collection('persons')
                            .where('malvoyantId', isEqualTo: widget.malvoyantId)
                            .where('firstname', isEqualTo: _searchController.text.trim())
                            .snapshots(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
