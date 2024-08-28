import 'package:flutter/material.dart';

class SelectLanguageWidget extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SelectLanguageWidget> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Dropdown'),
      ),
      body: Center(
        child: DropdownButton<String>(
          value: _selectedLanguage,
          onChanged: (String? newValue) {
            setState(() {
              _selectedLanguage = newValue!;
            });
          },
          items: [
            DropdownMenuItem(
              child: Row(
                children: [
                 // Image.asset('assets/flags/us.png', width: 20, height: 20),
                  SizedBox(width: 10),
                  Text('English'),
                ],
              ),
              value: 'English',
            ),
            DropdownMenuItem(
              child: Row(
                children: [
                 // Image.asset('assets/flags/sa.png', width: 20, height: 20),
                  SizedBox(width: 10),
                  Text('Arabic'),
                ],
              ),
              value: 'Arabic',
            ),
            DropdownMenuItem(
              child: Row(
                children: [
                 // Image.asset('assets/flags/de.png', width: 20, height: 20),
                  SizedBox(width: 10),
                  Text('German'),
                ],
              ),
              value: 'German',
            ),
            DropdownMenuItem(
              child: Row(
                children: [
                  //Image.asset('assets/flags/cn.png', width: 20, height: 20),
                  SizedBox(width: 10),
                  Text('Chinese'),
                ],
              ),
              value: 'Chinese',
            ),
            DropdownMenuItem(
              child: Row(
                children: [
                 // Image.asset('assets/flags/es.png', width: 20, height: 20),
                  SizedBox(width: 10),
                  Text('Spanish'),
                ],
              ),
              value: 'Spanish',
            ),
          ],
        ),
      ),
    );
  }
}