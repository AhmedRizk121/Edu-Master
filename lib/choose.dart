import 'package:flutter/material.dart';
import 'section.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: choose());
  }
}

class choose extends StatefulWidget {
  const choose({super.key});

  @override
  State<choose> createState() => _chooseState();
}

class _chooseState extends State<choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text('wecome name', style: TextStyle(fontSize: 30.0)),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Text(
                'You Want To...',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Cairo',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 90.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const section()),
                  );
                },
                child: const Text(
                  "STUDY",
                  style: TextStyle(
                    fontSize: 35,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: "Cairo",
                  ),
                ),
              ),
              SizedBox(width: 100.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 70,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Test",
                  style: TextStyle(
                    fontSize: 35,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: "Cairo",
                  ),
                ),
              ),
            ],
          ),

          Container(
            child: Column(
              children: [
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
