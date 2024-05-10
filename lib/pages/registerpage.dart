import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      //create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      //add user details
      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
        int.parse(_phoneNumberController.text.trim()),
      );
    }
  }

  Future addUserDetails(String firstName, String lastName, String email, int phoneNumber) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'phone number': phoneNumber,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() == _confirmpasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Image de fond
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/clipfly-ai-20240417202439.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // SingleChildScrollView avec le contenu interne
            SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0 ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'HELLO THERE',
                        style: GoogleFonts.bebasNeue(fontSize:52),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Register below with your details!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),


                      const SizedBox(height: 20),

                      Container(
                        
                        decoration: BoxDecoration( 
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30), 
                          ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              // Firstname text Field
                              const SizedBox(height: 10),        
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.5),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: TextField(
                                        controller: _firstNameController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'First Name',
                                        ),
                                      ),
                                    ),
                                    // Line 
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),

                              // last name  text Field
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.5),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: TextField(
                                        controller: _lastNameController,
                                       
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Last Name',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),

                              // phone number  text Field
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.5),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: TextField(
                                        controller: _phoneNumberController,
                                        
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Phone Number',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),

                              // email  text Field
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.5),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: TextField(
                                        controller: _emailController,
                                        
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Email',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),

                              // password text Field
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.5),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: TextField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),

                              // lconfirm passsworf  text Field
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 253, 253).withOpacity(0.5),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: TextField(
                                        controller: _confirmpasswordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Confirm Password',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),


                              // Bouton signIn
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () => signUp(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 112, 206, 227),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Center(
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Not a member text
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'I am member!',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: widget.showLoginPage,
                                    child: const Text(
                                      ' Login Now',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 18, 159, 169),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
