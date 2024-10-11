import 'package:flutter_application_2/model/dish.dart';
import 'package:flutter_application_2/model/task.dart';
import 'package:flutter_application_2/services/task-service.dart';
import 'package:flutter_application_2/utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListDishes extends StatelessWidget {
  const ListDishes({super.key});

  addTask() async {
    TaskService service = TaskService(userId: Util.UID);

    Task task = Task(
        title: "Fetch Data in Flutter Firebase",
        description: "Create a New UI to fetch and display data",
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        isCompleted: false,
        createdOn: DateTime.now());

    service.addTask(task);
  }

  fetchTasks() async {
    print("fetchTasks executed... UID is: ${Util.UID}");
    TaskService service = TaskService(userId: Util.UID);
    service.getTasks();
  }

  getDishes(BuildContext context) {
    List<Dish> dishes = [
      Dish(
          imageURL:
              "https://firebasestorage.googleapis.com/v0/b/avlyn-demo-app.appspot.com/o/salad.png?alt=media&token=e45be6d2-db4e-4076-9a78-fd94a649a46d",
          name: "Salad",
          price: 300,
          rating: 4.5,
          color: Colors.amber[50]),
      Dish(
          imageURL:
              "https://firebasestorage.googleapis.com/v0/b/avlyn-demo-app.appspot.com/o/burger.png?alt=media&token=a93602f4-32e3-4dfa-ab31-3acbf59dc078",
          name: "Burger",
          price: 300,
          rating: 4.2,
          color: Colors.blueAccent[50]),
      Dish(
          imageURL:
              "https://firebasestorage.googleapis.com/v0/b/avlyn-demo-app.appspot.com/o/noodles%20(2).png?alt=media&token=fc4cad31-faec-495e-a587-350a94fd5eaf",
          name: "Noodles",
          price: 400,
          rating: 3.8,
          color: Colors.deepPurple[50]),
      Dish(
          imageURL:
              "https://firebasestorage.googleapis.com/v0/b/avlyn-demo-app.appspot.com/o/image%203.png?alt=media&token=cc429fe4-493d-4251-b4aa-2a78cc21c379",
          name: "Nachos",
          price: 120,
          rating: 4.0,
          color: Colors.orange[50]),
      Dish(
          imageURL:
              "https://firebasestorage.googleapis.com/v0/b/avlyn-demo-app.appspot.com/o/pizza%20(1).png?alt=media&token=b5af0806-61a3-4d01-81ad-fbfd313c0d49",
          name: "Pizza",
          price: 600,
          rating: 3.5,
          color: Colors.indigoAccent[50]),
    ];

    // List<ListTile> dishListElements = dishes
    //     .map((element) => ListTile(
    //         leading: const Icon(Icons.arrow_circle_right, color: Colors.amber),
    //         title: Text(element.name)))
    //     .toList();

    List<GestureDetector> dishListElements = dishes
        .map((element) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/dishdetail");
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                color: element.color,
                child: Row(
                  children: [
                    Image.network(
                      element.imageURL,
                      width: 64,
                      height: 64,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(element.name),
                        Text("\u20b9 ${element.price}"),
                        Text(element.rating.toString()),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ))
        .toList();

    return dishListElements;
  }
  logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu"),actions: [
        IconButton(onPressed: (){
          logout(context);
        }, 
        icon: const Icon(Icons.logout))
      ]),
      body: ListView(children: getDishes(context)),
       floatingActionButton: FloatingActionButton(
        onPressed: fetchTasks,
        child: const Icon(Icons.add),
      ),
    );
  }
}