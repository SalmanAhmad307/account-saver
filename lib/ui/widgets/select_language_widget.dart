import 'package:flutter/material.dart';

class SelectLanguageWidget extends StatefulWidget {
  const SelectLanguageWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SelectLanguageWidget> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Dropdown'),
      ),
      body: Center(
        child: DropdownButton<String>(
          value: _selectedLanguage,
          onChanged: (String? newValue) {
            setState(() {
              _selectedLanguage = newValue!;
            });
          },
          items: const[
            DropdownMenuItem(
              value: 'English',
              child: Row(
                children: [
                 // Image.asset('assets/flags/us.png', width: 20, height: 20),
                  SizedBox(width: 10),
                  Text('English'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Arabic',
              child: Row(
                children: [
                 // Image.asset('assets/flags/sa.png', width: 20, height: 20),
                  SizedBox(width: 10),
                  Text('Arabic'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'German',
              child: Row(
                children: [
                 // Image.asset('assets/flags/de.png', width: 20, height: 20),
                  SizedBox(width: 10),
                  Text('German'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Chinese',
              child: Row(
                children: [
                  //Image.asset('assets/flags/cn.png', width: 20, height: 20),
                  SizedBox(width: 10),
                  Text('Chinese'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Spanish',
              child: Row(
                children: [
                 // Image.asset('assets/flags/es.png', width: 20, height: 20),
                  SizedBox(width: 10),
                  Text('Spanish'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}