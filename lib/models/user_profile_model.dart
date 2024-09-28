// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  final String? fillName;
  final String? userName;
  final String? email;
  final String? phoneNumber;
  final String? countryId;
  // final String? identityNumber;
  final String? password;
  // final String? companyRegistration;
  final String? birthDate;
  final String? accountType;
  late final String? userId;

  UserProfile({
    this.fillName,
    this.userName,
    this.email,
    this.phoneNumber,
    this.countryId,
    // this.identityNumber,
    this.password,
    // this.companyRegistration,
    this.birthDate,
    this.accountType,
    this.userId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    fillName: json["fill_name"],
    userName: json["user_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    countryId: json["country_id"],
    // identityNumber: json["identity_number"],
    password: json["password"],
    // companyRegistration: json["company_registration"],
    birthDate: json["birth_date"],
    accountType: json["account_type"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "fill_name": fillName,
    "user_name": userName,
    "email": email,
    "phone_number": phoneNumber,
    "country_id": countryId,
    // "identity_number": identityNumber,
    "password": password,
    // "company_registration": companyRegistration,
    "birth_date": birthDate,
    "account_type": accountType,
    "user_id": userId,
  };
}
