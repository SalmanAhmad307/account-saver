import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Add a title parameter

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title, // Use the title parameter
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26.0,
                color: Colors.black54,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black45,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        IconButton(
          icon: const Icon(Icons.star, color: Color.fromARGB(255, 182, 155, 2)),
          onPressed: () {
            Navigator.pushNamed(context, '/favorites');
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications,
              color: Color.fromARGB(255, 199, 160, 3)),
          onPressed: () {
            Navigator.pushNamed(context, '/notifications');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
