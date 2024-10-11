
import 'package:flutter_application_2/model/turf.dart';
import 'package:flutter_application_2/services/turf-service.dart';
import 'package:flutter/material.dart';

class AddTurfsPage extends StatefulWidget {
  const AddTurfsPage({super.key});

  @override
  State<AddTurfsPage> createState() => _AddTurfsPageState();
}

class _AddTurfsPageState extends State<AddTurfsPage> {
  final formKey = GlobalKey<FormState>();
  Turf turf = Turf.getEmptyObject();
  TurfService service = TurfService();

  bool showProgress = false;

  addTurfToDB() async {
    formKey.currentState!.save();
    String result = await service.addTurf(turf);
    if (result.contains("Successfully")) {
      setState(() {
        showProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Turf")),
      body: showProgress
          ? const Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Please Wait..")
                  ]),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: turf.photos.isEmpty
                                ? const NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/avlyn-demo-app.appspot.com/o/Frame%201.png?alt=media&token=57aae33a-bd45-405b-a33d-e007dd000d1a"
                                  )
                                : NetworkImage(
                                    turf.photos[0],
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Enter Turf Name"),
                          onSaved: (value) {
                            turf.name = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Enter Turf Description"),
                          onSaved: (value) {
                            turf.description = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Enter Your Address Line"),
                          onSaved: (value) {
                            turf.addressLine = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Enter Your City"),
                          onSaved: (value) {
                            turf.city = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Enter Your State"),
                          onSaved: (value) {
                            turf.state = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Enter Your Country"),
                          onSaved: (value) {
                            turf.country = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Enter Turf Hourly Rental"),
                          onSaved: (value) {
                            turf.rent = int.parse(value!);
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: turf.condition,
                          items:
                              ["Select Condition", "new", "Old"].map((element) {
                            return DropdownMenuItem<String>(
                                value: element, child: Text(element));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              turf.condition = value!;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Enter Turf Capacity"),
                          onSaved: (value) {
                            turf.capacity = int.parse(value!);
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: turf.visibility,
                          items: ["Select Visibility", "Day", "Night", "Both"]
                              .map((element) {
                            return DropdownMenuItem<String>(
                                value: element, child: Text(element));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              turf.visibility = value!;
                            });
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.all(16),
                            child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    showProgress = true;
                                    addTurfToDB();
                                  });
                                },
                                child: const Text("Add New Turf")))
                      ],
                    )),
              ),
            ),
    );
  }
}
