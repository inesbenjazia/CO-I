// ignore_for_file: prefer_const_declarations, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:co_i_project/pages/blue_header.dart';
import 'package:co_i_project/pages/utilis.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  Uint8List? _image;
  Cloudinary cloudinary = CloudinaryObject.fromCloudName(cloudName: 'drj5ri6fn');
  
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
    // Remplacez ces valeurs par les vôtres
    final cloudName = 'dleaqwn1f'; // Votre nom de cloud
    //final apiKey = '462951723426424'; // Votre clé API
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
          final url = jsonMap['url'];
          // Utilisez l'URL comme vous le souhaitez
        });
      } else {
        // Gestion des erreurs
        print('Error uploading image: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Gestion des erreurs
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1.0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              children: <Widget>[
                // Header
                BlueHeader(),
                _image != null
                    ? CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.2,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 150, bottom: 20),
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
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Appel de la méthode pour sélectionner et uploader l'image
                selectImage();
                uploadImageCloudinary();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(21, 137, 179, 1),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'upload image',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}