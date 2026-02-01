import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: junior());
  }
}

class junior extends StatefulWidget {
  const junior({super.key});

  @override
  State<junior> createState() => _juniorState();
}

class _juniorState extends State<junior> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
