import 'package:flutter/material.dart';

class gantiPassword extends StatefulWidget {
  const gantiPassword({super.key});

  @override
  State<gantiPassword> createState() => _gantiPasswordState();
}

class _gantiPasswordState extends State<gantiPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('Ini adalah halaman ganti password')
          ],
        )
    
      ),
    );
  }
}
