import 'package:flutter/material.dart';

class Dish {
  String imageURL;
  String name;
  int price;
  double rating;
  Color? color;

  Dish(
      {required this.imageURL,
      required this.name,
      required this.price,
      required this.rating,
      required this.color});

  @override
  String toString() {
    return "$name | $price";
  }
}