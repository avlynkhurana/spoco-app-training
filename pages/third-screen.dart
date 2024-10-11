import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/fourth-screen.dart';

class ThirdScreen extends StatelessWidget {
const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context){
    // Data: which needs to be passed in next screen
    String quote = "Hello how have you been";
    return Scaffold(
      appBar: AppBar(title: const Text("Third Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          child:const Text("Navigate to Fourth screen"),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => FourthScreen(quoteReceived: quote,
            )));
          },
        )),
    );
  }
}