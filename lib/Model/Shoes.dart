import 'package:cloud_firestore/cloud_firestore.dart';

class Shoes {
  String id;
  String image;
  String name;
  String price;
  String gender;

  Shoes({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.gender,
  });

  factory Shoes.fromDoc(DocumentSnapshot doc) {
    return Shoes(
      id: doc['id'],
      image: doc['image'],
      name: doc['name'],
      price: doc['price'],
      gender: doc['gender'],
    );
  }
}
