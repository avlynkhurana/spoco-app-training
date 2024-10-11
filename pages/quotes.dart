import 'package:flutter/material.dart';

class Quotes extends StatefulWidget {
  const Quotes({super.key});

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {

  List<String> quotes = [
    "Be Exceptional", "Find Candle in Darkness rather than cursing the darkness",
    "In three words I can sum up everything I've learned about life: It goes o",
    "We must be willing to let go of the life we planned so as to have the life that is waiting for us"
  ];
  int idx = 0;
  void nextQuote(){
    setState(() {
      idx = (idx+1) % quotes.length;
      print("idx is: $idx");
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(quotes[idx],
          style: TextStyle(
            fontSize: 24,),),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          nextQuote();
        },
        child: Icon(Icons.add),
        ),
      )
    );
  }
}