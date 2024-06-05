import 'package:flutter/material.dart';
import 'package:mobile_gmf/Theme.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Center(
        child: 
        Text('Ini adalah halaman settings', style: whitekTextStyle,),
      )
    );
  }
}
