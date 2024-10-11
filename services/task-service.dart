
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/model/task.dart';
import 'package:flutter_application_2/utils/util.dart';

class TaskService {
  String userId;

  CollectionReference? taskCollection;

  TaskService({required this.userId}) {
    taskCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("tasks");
  }

  // Create a Task in DataBase
  addTask(Task task) {
    taskCollection!.add(task.toMap()).then((DocumentReference doc) =>
        print('Task Created with with ID: ${doc.id}'));
  }

  updateTask(Task task, String docId) {
    taskCollection!.doc(docId).update(task.toMap());
  }

  deleteTask(String docId) {
    taskCollection!.doc(docId).delete();
  }

  getTasks() {
    print("getTasks: ${Util.UID}");
    taskCollection!.get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var document in querySnapshot.docs) {
          print('${document.id} => ${document.data()}');
        }

        // Hint for 1.
        //querySnapshot.docs.map((e) => null);
      },
      onError: (e) => print("Error completing: $e"),
    );

    // 1. Convert the document.data() into List of Task Objects using map function
    // 2. Create a AddTask UI with 2 Text Fields (Title and Description) and a Button
    // 3. Create a ListTask UI and display data as ListView
  }
}

