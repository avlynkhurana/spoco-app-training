import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/pages/add-turfs-page.dart';
import 'package:flutter_application_2/pages/dish-detail.dart';
import 'package:flutter_application_2/pages/first-screen.dart';
import 'package:flutter_application_2/pages/fourth-screen.dart';
import 'package:flutter_application_2/pages/home-page.dart';
import 'package:flutter_application_2/pages/list-dishes.dart';
import 'package:flutter_application_2/pages/list-quotes.dart';
import 'package:flutter_application_2/pages/login-page-form.dart';
import 'package:flutter_application_2/pages/login-page.dart';
import 'package:flutter_application_2/pages/quotes.dart';
import 'package:flutter_application_2/pages/register-page.dart';
import 'package:flutter_application_2/pages/second-screen.dart';
import 'package:flutter_application_2/pages/slider-page.dart';
import 'package:flutter_application_2/pages/splash.dart';
import 'package:flutter_application_2/pages/third-screen.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase, FirebaseOptions;
import 'firebase_options.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //return const MaterialApp(home: Quotes());
    //return const MaterialApp(home: Home());
    //return const MaterialApp(home: Listquotes());
    //return const MaterialApp(home: ListDishes());
    //return const MaterialApp(home: Splash());
     return MaterialApp(
      title: "My App",
      debugShowCheckedModeBanner: false,

      // Named Routing
      initialRoute: "/",
      routes: {
        "/": (context) => const Splash(),
        "/home": (context) => const HomePage(),
        "/dishes": (context) => const ListDishes(),
        "/quotes": (context) => const Listquotes(),
        "/first": (context) => const FirstScreen(),
        "/second": (context) => const SecondScreen(),
        "/third": (context) => const ThirdScreen(),
        //"/fourth": (context) => FourthScreen(quoteReceived:"Be exceptional")
        "/dishdetail": (context) => const DishDetail(),
        "/login": (context) => const LoginPage(),
        //"/loginForm": (context) => const LoginPageForm(),
        "/register": (context) => const RegisterPage(),
        "/slider": (context) => const SliderPage(),
        "/add-turf": (context) => const AddTurfsPage(),


      },
    ); 
  }
}

