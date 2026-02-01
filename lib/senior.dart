import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: senior());
  }
}

class senior extends StatefulWidget {
  const senior({super.key});

  @override
  State<senior> createState() => _seniorState();
}

class _seniorState extends State<senior> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}