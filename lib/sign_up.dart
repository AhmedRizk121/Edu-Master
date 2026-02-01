import 'package:flutter/material.dart';

class signup extends StatelessWidget {
  const signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
      body: const signup_body(),
    );
  }
}

class signup_body extends StatefulWidget {
  const signup_body({super.key});

  @override
  State<signup_body> createState() => _signup_bodyState();
}

class _signup_bodyState extends State<signup_body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          children: [
            Image.asset('images/signup.jpg', height: 250.0),
            SizedBox(height: 50.0),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Cairo',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Align(
              alignment: Alignment.center,
              child: Text(
                'Enter valid information',
                style: TextStyle(
                  color: Color.fromARGB(150, 0, 0, 0),
                  fontFamily: 'Cairo',
                  fontSize: 20,
                ),
              ),
            ),

            SizedBox(height: 50.0),

            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: 'Enter your name',
                    prefixIcon: Icon(Icons.text_decrease, color: Colors.grey),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: 'Enter your Age',

                    prefixIcon: Icon(Icons.numbers, color: Colors.grey),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Email field
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your email',
                    contentPadding: EdgeInsets.all(15),

                    // 👇 دي اللي بتحط الأيقونة جوا الفيلد
                    prefixIcon: Icon(Icons.email, color: Colors.grey),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your password',
                    contentPadding: EdgeInsets.all(15),

                    // 👇 دي اللي بتحط الأيقونة جوا الفيلد
                    prefixIcon: Icon(Icons.password, color: Colors.grey),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
            SizedBox(height: 30.0),
            // Button
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 14, 39, 51),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5.0,
                  ),
                  child: Text(
                    "Create an Account",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 221, 238, 249),
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: Color.fromARGB(255, 0, 8, 255),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
