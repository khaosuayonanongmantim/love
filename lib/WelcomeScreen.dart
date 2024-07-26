import 'package:flutter/material.dart';
import 'package:project_new/bottom_navber.dart';
import 'package:project_new/regScreen.dart';
import 'loginScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 103, 102, 175),
              Color.fromARGB(255, 158, 221, 232),
            ],
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 200.0),
            ),
            const SizedBox(
              height: 5,
            ),
            // Add your image here
            Image.asset(
              'assets/pillars.png', // Replace with your image path
              height: 160,
              width: 160,
            ),
            const SizedBox(
              height: 10,
            ),
            // Add text below the image
            const Text(
              '𝕀𝕋𝔾',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 14, 11, 11),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '𝐈𝐧𝐭𝐞𝐫𝐠𝐞𝐭𝐡𝐞𝐫',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const loginScreen()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegScreen()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavbar()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                child: const Center(
                  child: Text(
                    'Coming Home',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'Login with Social Media',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
