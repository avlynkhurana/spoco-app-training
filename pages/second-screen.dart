import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
const SecondScreen({super.key});

  @override
  Widget build(BuildContext context){

    String quoteReceived =ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen")),
      body: Center(child: Text(quoteReceived)),
    );
  }
}