import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  // final String name;
  // final String description;
  // final String imageUrl;
  //
  // const Product({this.name, this.description, this.imageUrl});

  final String id;
  final String DogBreed;
  final String email;
  final String DogColor;
  final String DogDescription;
  final String DogGender;
  final String DogImage;
  final String DogName;
  final String DogSize;
  final String ImageUrl;
  final Timestamp createdAt;
  final String firstname;
  final String lastname;
  final String phoneno;
  final Timestamp updatedAt;

  const Product({
    this.id,
    this.DogBreed,
    this.email,
    this.DogColor,
    this.DogDescription,
    this.DogGender,
    this.DogImage,
    this.DogName,
    this.DogSize,
    this.ImageUrl,
    this.createdAt,
    this.firstname,
    this.lastname,
    this.phoneno,
    this.updatedAt,
  });

  // static const List<Product> products = [
  //   Product(
  //       name: 'IMAC Laptop',
  //       price: 2.19,
  //       imageUrl:
  //           'https://promomyanmar.com/wp-content/uploads/2020/08/best-gaming-pc-2020.jpg'),
  //   Product(
  //       name: 'INTEL Desktop',
  //       price: 2.19,
  //       imageUrl:
  //           'https://www.gamingscan.com/wp-content/uploads/2020/07/Best-Custom-PC-Builders.jpg'),
  //   Product(
  //       name: 'Mac LCD',
  //       price: 2.19,
  //       imageUrl:
  //           'https://deasilex.com/wp-content/uploads/2021/03/New-Released-PC-Games-1024x576.jpg'),
  // ];

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      DogBreed: snap['DogBreed'],
      email: snap['email'],
      DogColor: snap['DogColor'],
      DogDescription: snap['DogDescription'],
      DogGender: snap['DogGender'],
      DogImage: snap['DogImage'],
      DogName: snap['DogName'],
      id: snap['uid'],
      DogSize: snap['DogSize'],
      ImageUrl: snap['ImageUrl'],
      createdAt: snap['createdAt'],
      phoneno: snap['phoneno'],
      firstname: snap['firstname'],
      lastname: snap['lastname'],
      updatedAt: snap['updatedAt'],
    );
    return product;
  }
}
