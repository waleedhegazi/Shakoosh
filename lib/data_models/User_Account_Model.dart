import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

class UserAccountModel {
  String id;
  String email;
  String password;
  String firstName;
  String lastName;
  final String creationDate;
  String phoneNumber;
  String? profilePicURL;
  Image? profilePic;
  SvgPicture star = Assets.ratingStarsImages[5];
  double rate = 5;
  int raters;
  List<dynamic> locations;

  UserAccountModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.creationDate,
      this.profilePicURL,
      this.profilePic,
      this.rate = 5,
      this.raters = 0,
      required this.locations});

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json['password'],
        phoneNumber: json['phone_number'],
        rate: json['rate_ratio'],
        raters: json['number_of_raters'],
        creationDate: json['creation_date'],
        profilePicURL: json['profile_pic_url'],
        profilePic: (json['profile_pic_url'] != null)
            ? Image.network(json['profile_pic_url'])
            : null,
        locations: json['locations'].map((locationMap) {
          print("Heloooooooooooooooooooooo ");
          return Location.fromJson(locationMap);
        }).toList());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "phone_number": phoneNumber,
      "rate_ratio": rate,
      "number_of_raters": raters,
      "creation_date": creationDate,
      "locations": locations,
      "profile_pic_url": profilePicURL
    };
  }

  void setProfilePicURL(String? newURL) {
    profilePicURL = newURL;
  }

  void setProfilePic(String newURL) {
    profilePic = Image.network(newURL);
  }

  String? getProfilePicURL() {
    return profilePicURL;
  }

  Image getProfilePic() {
    if (profilePicURL != null) {
      return profilePic!;
    } else {
      return Assets.anonymousImage;
    }
  }

  String getId() {
    return id;
  }

  String getEmail() {
    return email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getFirstName() {
    return firstName;
  }

  void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  String getLastName() {
    return lastName;
  }

  void setLastName(String lastName) {
    this.lastName = lastName;
  }

  String getPassword() {
    return password;
  }

  void setPassword(String password) {
    this.password = password;
  }

  double getRate() {
    return rate;
  }

  int getRaters() {
    return raters;
  }

  String getPhoneNumber() {
    return phoneNumber;
  }

  String getPhoneNumberFormatted() {
    return "(+2) ${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 7)} ${phoneNumber.substring(7)}";
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  String getCreationDate() {
    return creationDate;
  }

  List<dynamic> getLocations() {
    return locations;
  }

  Location getLocationAt(int index) {
    return locations[index];
  }

  void setLocations(List<Location> newList) {
    locations = newList;
  }

  void clearLocations() {
    locations.clear();
  }

  void addLocation(Location newLocation) {
    locations.add(newLocation);
  }

  void addLocationAt(Location newLocation, int index) {
    locations.insert(index, newLocation);
  }

  void deleteLocation(int index) {
    locations.removeAt(index);
  }

  SvgPicture getStar() {
    if (rate == 5) {
      return Assets.ratingStarsImages[5];
    }
    if (rate > 4) {
      return Assets.ratingStarsImages[4];
    }
    if (rate > 3) {
      return Assets.ratingStarsImages[3];
    }
    if (rate > 2) {
      return Assets.ratingStarsImages[2];
    }
    if (rate > 1) {
      return Assets.ratingStarsImages[1];
    }
    return Assets.ratingStarsImages[0];
  }
}

class Location {
  final String title;
  final String city;
  final String street;
  final String buildingNo;
  final String floorNo;
  final String apartmentNo;
  final GeoFirePoint geo;
  Location(
      {required this.city,
      required this.street,
      required this.buildingNo,
      this.floorNo = '--',
      this.apartmentNo = '--',
      required this.geo,
      required this.title});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        geo: GeoFirePoint(json['geo']['geopoint'].latitude,
            json['geo']['geopoint'].longitude),
        title: json['name'],
        city: json['city'],
        street: json['street'],
        buildingNo: json['building_number'],
        floorNo: json['floor_number'],
        apartmentNo: json['apartment_number']);
  }

  Map<String, dynamic> toJson() {
    return {
      'geo': geo.data,
      'name': title,
      'city': city,
      'street': street,
      'building_number': buildingNo,
      'floor_number': floorNo,
      'apartment_number': apartmentNo,
    };
  }
}

class Accounts {
  static UserAccountModel dummyAccount = UserAccountModel(
      id: "id",
      firstName: 'User',
      lastName: 'name',
      email: 'user.email@gmail.com',
      password: 'Cars44',
      phoneNumber: '01101601978',
      rate: 4,
      raters: 23,
      locations: [],
      creationDate: (DateFormat.yMMMd().format(DateTime.now())).toString());

  static bool isEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r"^(?=.*[a-z])").hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r"^(?=.*[A-Z])").hasMatch(password);
  }

  static bool hasDigits(String password) {
    return RegExp(r"^(?=.*?[0-9])").hasMatch(password);
  }

  static bool hasSpecialChar(String password) {
    return RegExp(r"^(?=.*?[!@#\$&*~])").hasMatch(password);
  }

  static bool hasCharsOnly(String text) {
    return RegExp(r"^([A-Za-z\s]+$)").hasMatch(text);
  }
}
