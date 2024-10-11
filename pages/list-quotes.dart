import 'package:flutter/material.dart';
class Listquotes extends StatelessWidget {
  const Listquotes({super.key});


  getQuotes(){
    List<String> quotes = [
    "Be Exceptional", "Find Candle in Darkness rather than cursing the darkness",
    "In three words I can sum up everything I've learned about life: It goes",
    "We must be willing to let go of the life we planned so as to have the life that is waiting for us"
  ];
  /*List<Text> quoteTextList = [];

  for(int idx = 0; idx <quotes.length; idx++){
    quoteTextList.add(Text(quotes[idx]));
  }*/
  //List<Text> quoteTextList = quotes.map((element) => Text(element)).toList();
  /*List<ListTile> quoteTextList =[];
  for(int idx = 0;idx<quotes.length; idx++){
    quoteTextList.add(ListTile(
       leading: const Icon(Icons.format_quote), title: Text(quotes[idx])));
  }*/

  List<ListTile> quoteTextList = quotes.map((element) => ListTile(
       leading: const Icon(Icons.format_quote), title: Text(element))).toList();
       
  return quoteTextList;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: const Text("List of Quotes")),
    body: ListView(children: getQuotes())
  );
  }
}