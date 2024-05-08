

import 'package:co_i_project/pages/main_page.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image en arrière-plan
          Positioned.fill(
            child: Image.asset(
              'lib/images/background.png', // Remplacez 'background_image.jpg' par le chemin de votre image
              fit: BoxFit.cover,
            ),
          ),
          // Contenu de la page
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.1, // Ajustez cette valeur pour positionner le bouton
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Naviguer vers la page MainPage lorsqu'on appuie sur le bouton
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Color.fromARGB(255, 18, 159, 169),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}