import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/pages/list-my-turfs.dart';
import 'package:flutter_application_2/pages/list-turfs.dart';
import 'package:flutter_application_2/pages/multi-image-upload.dart';
import 'package:flutter_application_2/pages/profile-page.dart';
import 'package:flutter_application_2/utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/profile-page.dart';
import 'package:flutter_application_2/utils/util.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  getLocationOfUser() async {
    Position position = await _determinePosition();
    // Current Location of User
    print("Location/Position is: ${position.latitude}, ${position.longitude}");
    Util.geoPoint = GeoPoint(position.latitude, position.longitude);
  }

  List<Widget> widgets = [
    //const Text("Home Page"), // 0
    const ListTurfs(),
    const ListMyTurfs(),
    // const MyTurfsPage(), // 1
    //const Text("Players Page"), // 2
    //const MultiImageUpload(),
    const ProfilePage() // 3
  ];

  List<BottomNavigationBarItem> navBaritems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_football), label: "Turfs"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_handball), label: "Players"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/");
  }

  onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocationOfUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page"), actions: [
        IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout))
      ]),
      body: Center(child: widgets[selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: navBaritems,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[500],
        unselectedItemColor: Colors.black54,
        onTap: onItemSelected,
      ),
    );
  }
}