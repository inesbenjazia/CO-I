
// ignore_for_file: unused_field, prefer_const_declarations, use_build_context_synchronously, avoid_print

import 'dart:typed_data';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:co_i_project/services/firestore.dart';
import 'dart:convert';
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'utilis.dart';

import 'package:http/http.dart' as http;
import 'blue_header.dart';
import 'package:image_picker/image_picker.dart';

class AddPersonPage extends StatefulWidget {
  final String malvoyantId ;
 const AddPersonPage({super.key, required this.malvoyantId}) ;

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}
 
class _AddPersonPageState extends State<AddPersonPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();
  
  Uint8List? _image;
  String? _imageUrl; 
  Cloudinary cloudinary = CloudinaryObject.fromCloudName(cloudName: 'drj5ri6fn');
  

  bool _uploadingImage = false;
  bool _addingPerson = false;
  
  void selectImage() async {
  final img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });

  // Une fois que l'image est sélectionnée, téléchargez-la sur Cloudinary
  if (_image != null) {
    uploadImageCloudinary();
  }
}


Future<void> uploadImageCloudinary() async {
   setState(() {
      _uploadingImage = true;
    });
    // Remplacez ces valeurs par les vôtres
    final cloudName = 'dleaqwn1f'; // Votre nom de cloud
    final uploadPreset = 'fix5xyet'; // Votre preset d'upload

    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(http.MultipartFile.fromBytes('file', _image!, filename: 'image.jpg'));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        setState(() {
          _imageUrl = jsonMap['url'];
          // Utilisez l'URL comme vous le souhaitez
        });

        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image uploaded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Gestion des erreurs
        print('Error uploading image: ${response.reasonPhrase}');

        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading image: ${response.reasonPhrase}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Gestion des erreurs
      print('Error uploading image: $e');

      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading image: $e'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _uploadingImage = false;
      });
    }
  }

 Future<void> addPerson() async {
    setState(() {
      _addingPerson = true;
    });

    // Récupérer les valeurs des champs texte
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String? imageUrl = _imageUrl;
    String relationship = _relationshipController.text;

    // Ajouter une nouvelle personne avec les données fournies
    try {
      await firestoreService.addPersonToMalvoyant(
        firstName,
        lastName,
        imageUrl!,
        relationship,
        widget.malvoyantId,
      );

      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contact added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Gestion des erreurs
      print('Error adding person: $e');

      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding person: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _addingPerson = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        // Header
            BlueHeader(
              
            ),
             _image != null
                    ? CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.2,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 70, bottom: 20),
                        child: SizedBox(
                          height: 250,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3.8, // Définir l'épaisseur de la bordure
                              ),
                            ),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.height * 0.3,
                              backgroundImage: const AssetImage('lib/images/user.png'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                onPressed: _uploadingImage ? null : () {
                // Appel de la méthode pour sélectionner et uploader l'image
                selectImage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(21, 137, 179, 1),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                 _uploadingImage ? 'Uploading...' : 'Upload image',
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
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
              controller: _relationshipController,
              decoration: const InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Récupérer les valeurs des champs texte
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String? imageUrl = _imageUrl;
                String relationship = _relationshipController.text;

                // Ajouter une nouvelle personne avec les données fournies
                firestoreService.addPersonToMalvoyant(
                  firstName,
                  lastName,
                  imageUrl!,
                  relationship,
                  widget.malvoyantId
                  
                  
                );

                // Effacer les champs texte après l'ajout
                _firstNameController.clear();
                _lastNameController.clear();
                
                _relationshipController.clear();

                // Naviguer vers l'écran précédent
                Navigator.pop(context);
              },
              child: const Text('Add Person'),
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