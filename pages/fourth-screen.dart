import 'package:flutter/material.dart';

class FourthScreen extends StatelessWidget {
  final String quoteReceived;

  const FourthScreen({super.key, required this.quoteReceived});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Fourth Screen")),
      body: Center(child: Text(quoteReceived)),
    );
  }
}