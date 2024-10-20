/*
{
"title" :"",
"description" :"",
"status" :"",
"status" :"",
"file" :"",
"additional_info" :"",
"type_investor" :"",
"idea_category" :"",
"target_audience" :"",
"business_model" :"",
"budget_minimum" :"",
"budget maximum" :"",
"supporting_documents" :[
"1",
"2"],
"intellectualPropertyStatus" :"",
"userId" :"",
"uploadedAt" :""
}
 */

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Idea ideaFromJson(String str) => Idea.fromJson(json.decode(str));

String ideaToJson(Idea data) => json.encode(data.toJson());

class Idea {
  final String? title;
  final String? idea_id;
  final String? description;
  final String? status;
  final String? file;
  final String? image;
  final String? additionalInfo;
  final String? typeInvestor;
  final String? ideaCategory;
  final String? targetAudience;
  final String? businessModel;
  final String? budgetMinimum;
  final String? budgetMaximum;
  final List<String>? supportingDocuments;
  final String? intellectualPropertyStatus;
  final String? userId;
  final String? uploadedAt;

  Idea({
    this.title,
    this.description,
    this.idea_id,
    this.status,
    this.file,
    this.additionalInfo,
    this.image,
    this.typeInvestor,
    this.ideaCategory,
    this.targetAudience,
    this.businessModel,
    this.budgetMinimum,
    this.budgetMaximum,
    this.supportingDocuments,
    this.intellectualPropertyStatus,
    this.userId,
    this.uploadedAt,
  });

  factory Idea.fromJson(Map<String, dynamic> json) => Idea(
    title: json["title"],
    description: json["description"],
    status: json["status"],
    file: json["file"],
    idea_id: json["idea_id"],
    additionalInfo: json["additional_info"],
    typeInvestor: json["type_investor"],
    ideaCategory: json["idea_category"],
    image: json["image"],
    targetAudience: json["target_audience"],
    businessModel: json["business_model"],
    budgetMinimum: json["budget_minimum"],
    budgetMaximum: json["budget maximum"],
    supportingDocuments: json["supporting_documents"] == null ? [] : List<String>.from(json["supporting_documents"]!.map((x) => x)),
    intellectualPropertyStatus: json["intellectualPropertyStatus"],
    userId: json["userId"],
    uploadedAt: json["uploadedAt"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "image": image,
    "status" :"pending",
    "uploaded_at": FieldValue.serverTimestamp(),
    "file": file,
    "additional_info": additionalInfo,
    "type_investor": typeInvestor,
    "idea_category": ideaCategory,
    "target_audience": targetAudience,
    "business_model": businessModel,
    "idea_id": idea_id,
    "budget_minimum": budgetMinimum,
    "budget maximum": budgetMaximum,
    "supporting_documents": supportingDocuments == null ? [] : List<dynamic>.from(supportingDocuments!.map((x) => x)),
    "intellectualPropertyStatus": intellectualPropertyStatus,
    "userId": userId,


  };
}
