import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const Text(
            "Edu",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Master",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

