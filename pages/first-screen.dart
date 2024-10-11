import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
const FirstScreen({super.key});

  @override
  Widget build(BuildContext context){
    // Data: which needs to be passed in next screen
    String quote = "Search the candle rather than cursing the darkness";
    return Scaffold(
      appBar: AppBar(title: const Text("First Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          child:const Text("Navigate to Second screen"),
          onPressed: (){
            Navigator.of(context).pushNamed("/second",arguments: quote);
          },
        )),
    );
  }
}