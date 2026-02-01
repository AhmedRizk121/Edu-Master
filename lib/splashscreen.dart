import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gproject/welcome.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const welcome()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 39, 51),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0), // ← يخليها دايرة
                image: DecorationImage(
                  image: AssetImage('images/6.png'),
                  fit: BoxFit.cover, // ← عشان تملى الدايرة
                ),
              ),
            ),
            SizedBox(height: 20),
            const Text(
              "Edu Master",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "For Graduation project",
              style: TextStyle(color: Colors.white70, fontSize: 26),
            ),

            const Text(
              "with DR/Magdy",
              style: TextStyle(color: Colors.white70, fontSize: 26),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
