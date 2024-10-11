
// Task: title, description, startDate, endDate, isCompleted, createdOn
// Vehicle: regNumber. model, brand, color, type, createdOn
// Dish: name, ateOn, calories, type
// ....

class Task {
  // Attributes
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  bool isCompleted;
  DateTime createdOn;

  // Constructor
  Task(
      {required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.isCompleted,
      required this.createdOn});

  // Serialization
  // toMap i.e. Map representation of Object
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
      "isCompleted": isCompleted,
      "createdOn": createdOn.toIso8601String()
    };
  }

  // DeSerialization
  // Create a Task from a Map
  static Task fromMap(Map<String, dynamic> map) {
    return Task(
        title: map["title"],
        description: map["description"],
        startDate: map["startDate"],
        endDate: map["endDate"],
        isCompleted: map["isCompleted"],
        createdOn: map["createdOn"]);
  }
}
