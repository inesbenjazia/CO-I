import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController textControllerUsername = TextEditingController();
  final TextEditingController textControllerPassword = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/clipfly-ai-20240417202439.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 100, // Adjust the distance from the top
            bottom: 100, // Adjust the distance from the bottom
            left: 20,
            right: 20,
            child: Center(
              child: Container(
                width: 400, // Adjust the width
                height: 400, // Adjust the height
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: textControllerUsername,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 196, 196, 196)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 180, 180, 180)),
                        ),
                        fillColor: Color.fromARGB(255, 240, 240, 240),
                        filled: true,
                        // hintText: hintText,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: textControllerPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 196, 196, 196)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 180, 180, 180)),
                        ),
                        fillColor: Color.fromARGB(255, 240, 240, 240),
                        filled: true,
                        // hintText: hintText,
                      ),
                    ),
                    // Add more text fields or login form elements here
                    //const SizedBox(height: 5),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(255, 70, 70, 70),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration:  BoxDecoration(
                        color: const Color.fromARGB(255, 17, 0, 52),
                        borderRadius: BorderRadius.circular(8)
                        ),
                      child: const Center(
                        child: Text("Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          ),
                        ),
                        )
                     ),
                    )

                    
                  ],
                ),
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}
