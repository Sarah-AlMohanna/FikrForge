// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  final String? fillName;
  final String? profileImage;
  final String? bio;
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
    this.profileImage,
    this.userName,
    this.bio,
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
    bio: json["bio"],
    userName: json["user_name"],
    profileImage: json["profile_image"],
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
    "bio": bio,
    "phone_number": phoneNumber,
    "country_id": countryId,
    "profile_image": profileImage,
    // "identity_number": identityNumber,
    "password": password,
    // "company_registration": companyRegistration,
    "birth_date": birthDate,
    "account_type": accountType,
    "user_id": userId,
  };
}
