import 'dart:convert';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? id;
  final String title;
  final String description;
  final String imageUrl;
  final int price;
  final int quantity;
  final String category;
  final String adminId;
  final int sales;
  final int views;
  final double averageRating;
  final List reviews;

  const Product(
    this.title,
    this.description,
    this.imageUrl,
    this.price,
    this.quantity,
    this.adminId,
    this.category, {
    this.sales = 0,
    this.views = 0,
    this.id,
    this.averageRating = 0,
    this.reviews = const [],
  });

  factory Product.fromMap(Map map) {
    return Product(
      map['title'],
      map['description'],
      map['imageUrl'],
      map['price'],
      map['quantity'],
      map['adminId'],
      map['category'],
      sales: map['sales'],
      views: map['views'],
      id: map['_id'],
      averageRating: map['averageRating'].toDouble(),
      reviews: map['reviews'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'adminId': adminId,
      'category': category,
      'sales': sales,
      'views': views,
      '_id': id,
      'averageRating': averageRating,
      'reviews': reviews,
    };
  }

  //Json serialization
  factory Product.fromJson(string) {
    return Product.fromMap(json.decode(string));
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [id, title, description, imageUrl, price, quantity, adminId, sales, views];
}
