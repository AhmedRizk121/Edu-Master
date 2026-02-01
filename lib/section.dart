import 'package:flutter/material.dart';
import 'senior.dart';
import 'junior.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: section());
  }
}

class section extends StatefulWidget {
  const section({super.key});

  @override
  State<section> createState() => _sectionState();
}

class _sectionState extends State<section> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 51, 67),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 18, 51, 67)),
      body: Column(
        children: [
          Center(
            child: Text(
              'Choose Your Sector',
              style: TextStyle(
                color: Color.fromARGB(255, 221, 238, 249),
                fontFamily: 'Cairo',
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 25.0),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 25, 61, 75),
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const senior()),
              );
            },
            child: Column(
              children: [
                const Text(
                  "Senior",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontFamily: "Cairo",
                  ),
                ),
                const SizedBox(width: 20),
                Image.asset('images/college.png', height: 150),
              ],
            ),
          ),

          SizedBox(height: 40.0),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 25, 61, 75),
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const junior()),
              );
            },
            child: Column(
              children: [
                const Text(
                  "Junior",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontFamily: "Cairo",
                  ),
                ),
                const SizedBox(width: 20),
                Image.asset('images/Teacher-pana.png', height: 150),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
