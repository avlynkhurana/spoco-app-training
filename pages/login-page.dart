
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/model/user.dart';
import 'package:flutter_application_2/utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Kind of Constructor
  @override
  void initState() {
    super.initState();
  }

  // Kind of Destructor
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print("User Sign in with : Email: $email | Password: $password");
        print("Credential: $credential");
        print("UID: ${credential.user!.uid}");

        final docRef = FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid);
        docRef.get().then(
          (DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            Util.user = AppUser.fromMap(data);
            Navigator.of(context).pushReplacementNamed("/home");
          },
          onError: (e) => print("Error getting document: $e"),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        print(e);
      }

      print("Details: Email: $email | Password: $password");
    } else {
      print("Missing Details: Email: $email | Password: $password");
    }
  }

  styleTextField(String hintText) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2)),
      // enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(12),
      //     borderSide: const BorderSide(color: Colors.amber, width: 2)),
      // focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(12),
      //     borderSide: const BorderSide(color: Colors.purple, width: 2)),
      //fillColor: Colors.blueAccent[100],
      //filled: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/avlyn-demo-app.appspot.com/o/photo.png?alt=media&token=1a8128c6-15d3-4492-9f3b-74da17af82b2",
              width: 64,
              height: 64,
            ),
            const Text(
              "Welcome",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: emailController,
              //decoration: const InputDecoration(labelText: "Email"),
              decoration: styleTextField("Email"),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: passwordController,
              //decoration: const InputDecoration(labelText: "Password"),
              decoration: styleTextField("Password"),
              obscureText: true,
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(onPressed: login, child: const Text("Login")),
            const SizedBox(
              height: 12,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/register");
                },
                child: const Text("New User? Register Here"))
          ],
        ),
      ),
    );
  }
}
