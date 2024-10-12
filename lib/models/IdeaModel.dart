// To parse this JSON data, do
//
//     final idea = ideaFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Idea ideaFromJson(String str) => Idea.fromJson(json.decode(str));

String ideaToJson(Idea data) => json.encode(data.toJson());

class Idea {
  final String? title;
  final String? description;
  final String? status;
  final String? image;
  final String? userId;
  final Timestamp? uploadedAt;

  Idea({
    this.title,
    this.description,
    this.status,
    this.image,
    this.userId,
    this.uploadedAt,
  });

  factory Idea.fromJson(Map<String, dynamic> json) => Idea(
    title: json["title"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    userId: json["user_id"],
    uploadedAt: json["uploaded_at"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "image": image,
    "status" :"pending",
    "user_id": userId,
    "uploaded_at": FieldValue.serverTimestamp(),
  };
}
