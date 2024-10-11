
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/model/user.dart';
import 'package:flutter_application_2/utils/util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //AppUser user = AppUser.getAppUserEmptyObject();
  AppUser user = Util.user!;

  final formKey = GlobalKey<FormState>();

  pickDateOfBirth() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime(2024),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (date != null) {
      setState(() {
        user.dateOfBirth = date;
        user.age = DateTime.now().year - date.year;
        print("User Age is: ${user.age}");
      });
    }
  }

  saveUserInFirebaseFirestore() {
    formKey.currentState!.save();
    print("User Data: ${user.toMap().toString()}");

    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(Util.UID)
          .set(user.toMap())
          .then((value) {
        print("User Data: ${user.toMap().toString()} Saved in Firestore");
        // Show SnackBar :) i.e. Toast
      });
    } catch (e) {
      print("Exception while saving user profile");
      print(e);
    }
  }

  pickupProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      print("File Path: ${file.path}");

      final storageRef = FirebaseStorage.instance.ref();
      final profilePicsRef = storageRef.child("profile-pics/${Util.UID}.png");
      try {
        await profilePicsRef.putFile(file);
        user.imageURL = await profilePicsRef.getDownloadURL();
        print("Image URL: ${user.imageURL}");
        saveUserInFirebaseFirestore();
        print("Image Url is: ${user.imageURL}");
      } catch (e) {
        print("Something Went Wrong...");
        print(e);
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(user.toMap().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickupProfileImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: user.imageURL.isEmpty
                          ? const NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/avlyn-demo-app.appspot.com/o/Frame%201.png?alt=media&token=57aae33a-bd45-405b-a33d-e007dd000d1a",
                            )
                          : NetworkImage(
                              user.imageURL,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your Name"),
                    onSaved: (value) {
                      user.name = value!;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your Phone"),
                    initialValue: user.phone.isNotEmpty ? user.phone : "",
                    onSaved: (value) {
                      user.phone = value!;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your Email"),
                    onSaved: (value) {
                      user.email = value!;
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Select Gender:"),
                      ListTile(
                        title: const Text("Male"),
                        leading: Radio<String>(
                          value: "Male",
                          groupValue: user.gender,
                          onChanged: (value) {
                            setState(() {
                              user.gender = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text("Female"),
                        leading: Radio<String>(
                          value: "Female",
                          groupValue: user.gender,
                          onChanged: (value) {
                            setState(() {
                              user.gender = value!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  DropdownButtonFormField<String>(
                    value: user.sports,
                    items: ["Select Sports", "Cricket", "Badminton", "Soccer"]
                        .map((element) {
                      return DropdownMenuItem<String>(
                          value: element, child: Text(element));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        user.sports = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Enter Your Address Line"),
                    onSaved: (value) {
                      user.addressLine = value!;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your City"),
                    onSaved: (value) {
                      user.city = value!;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your State"),
                    onSaved: (value) {
                      user.state = value!;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your Country"),
                    onSaved: (value) {
                      user.country = value!;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: user.role,
                    items: ["Select Role", "Player", "Coach", "TurfOwner"]
                        .map((element) {
                      return DropdownMenuItem<String>(
                          value: element, child: Text(element));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        user.role = value!;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: user.highestPlayedLevel,
                    items: [
                      "Select Highest Played Level",
                      "Zonal",
                      "District",
                      "State"
                    ].map((element) {
                      return DropdownMenuItem<String>(
                          value: element, child: Text(element));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        user.highestPlayedLevel = value!;
                      });
                    },
                  ),
                  ListTile(
                    title: (Text(
                        "Date of Birth: ${user.dateOfBirth.day}/${user.dateOfBirth.month}/${user.dateOfBirth.year}")),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: pickDateOfBirth,
                  ),
                  SwitchListTile(
                    title: const Text("Have you Represented a Club ?"),
                    value: user.representClub,
                    onChanged: (value) {
                      setState(() {
                        user.representClub = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Enter Your Club Name"),
                    onSaved: (value) {
                      user.clubName = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Enter Your School/College/Organization"),
                    onSaved: (value) {
                      user.schoolCollegeOrgName = value!;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your Username"),
                    onSaved: (value) {
                      // write the firebase query to check if the same username exists
                      user.username = value!;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                          onPressed: saveUserInFirebaseFirestore,
                          child: const Text("Save Profile")))
                ],
              )),
        ),
      ),
    );
  }
}

// 1. Explore SnackBar and show a message when profile is saved
// 2. Find the Bug, which is making data loss in scroll
