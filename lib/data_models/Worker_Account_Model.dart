import 'package:flutter/material.dart';
import 'package:test_app/Assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_app/Shakoosh_icons.dart';
import 'package:intl/intl.dart';
import 'package:test_app/data_models/User_Account_Model.dart';

class Worker {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String creationDate;
  final String phoneNumber;
  final String profession;
  final String? profilePicURL;
  final Image profilePic;
  final double rate;
  final String hourlyRate;
  final int raters;
  final List<bool> timeTable;
  Map<String, dynamic> location;
  List<Review> reviews = [
    Review(
        reviewerName: 'Mohamed Ahmed',
        reviewText:
            'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test',
        date: (DateFormat.yMMMd().format(DateTime.now())).toString(),
        rate: 3),
    Review(
        reviewerName: 'Mohamed Ahmed',
        reviewText:
            'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test',
        date: (DateFormat.yMMMd().format(DateTime.now())).toString(),
        rate: 3),
    Review(
        reviewerName: 'Mohamed Ahmed',
        reviewText:
            'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test',
        date: (DateFormat.yMMMd().format(DateTime.now())).toString(),
        rate: 3),
    Review(
        reviewerName: 'Mohamed Ahmed',
        reviewText:
            'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test',
        date: (DateFormat.yMMMd().format(DateTime.now())).toString(),
        rate: 3)
  ];

  Worker(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.creationDate,
      required this.profilePicURL,
      required this.rate,
      required this.raters,
      required this.location,
      required this.profilePic,
      required this.profession,
      required this.timeTable,
      required this.hourlyRate});

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        profession: json['profession'],
        rate: json['rate_ratio'],
        raters: json['number_of_raters'],
        creationDate: json['creation_date'],
        timeTable: json['time_table'],
        hourlyRate: json['hourly_rate'],
        location: json['location'],
        profilePicURL: json['profile_pic_url'],
        profilePic: (json['profile_pic_url'] != null)
            ? Image.network(json['profile_pic_url'])
            : Assets.anonymousImage);
  }

  Image getProfilePic() {
    return profilePic;
  }

  String getId() {
    return id;
  }

  String getEmail() {
    return email;
  }

  String getFirstName() {
    return firstName;
  }

  String getLastName() {
    return lastName;
  }

  double getRate() {
    return rate;
  }

  int getRaters() {
    return raters;
  }

  String getPhoneNumberFormatted() {
    return "(+2) ${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 7)} ${phoneNumber.substring(7)}";
  }

  String getCreationDate() {
    return creationDate;
  }

  List<Review> getReviews() {
    return reviews;
  }

  String getProfession() {
    return profession;
  }

  String getHourlyRate() {
    return hourlyRate;
  }

  List<bool> getTimeTable() {
    return timeTable;
  }

  bool getTimeTableAt(int index) {
    return timeTable[index];
  }

  IconData getIconData() {
    switch (profession) {
      case 'Carpenter':
        return ShakooshIcons.carpenter2;
      case 'Plumber':
        return ShakooshIcons.plumber2;
      case 'Painter':
        return ShakooshIcons.decorator1;
      case 'Electrician':
        return ShakooshIcons.electrician2;
      case 'Bricklayer':
        return ShakooshIcons.bricklayer2;
    }
    return ShakooshIcons.logo_transparent_black_2;
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

class Review {
  final String reviewerName;
  final String reviewText;
  final String date;
  final int rate;

  Review(
      {required this.reviewerName,
      required this.reviewText,
      required this.date,
      required this.rate});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        reviewerName: json['client_name'],
        reviewText: json['review_text'],
        date: json['date'],
        rate: json['rate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewer_name': reviewerName,
      'review_text': reviewText,
      'date': date,
      'rate': rate
    };
  }

  String getReviewerName() {
    return reviewerName;
  }
}

class SearchFilter {
  final String profession;
  Location? location;
  List<bool> times = [];
  SearchFilter({
    required this.profession,
  });

  void setLocation(Location newLocation) {
    location = newLocation;
  }

  Location getLocation() {
    return location!;
  }

  void initTimes() {
    for (int i = 0; i < 56; i++) {
      times.add(false);
    }
  }

  List<bool> getTimes() {
    return times;
  }

  bool getTimeAt(int index) {
    return times[index];
  }

  bool isFilled() {
    for (int i = 0; i < 56; i++) {
      if (times[i] == true) {
        return true;
      }
    }
    return false;
  }

  void invertAt(int index) {
    times[index] = !times[index];
  }

  void resetLocationAndTime() {
    location = null;
    times = [];
  }

  static SearchFilter currentFilter = SearchFilter(profession: 'Carpenter');
  static void createFilter(String profession) {
    currentFilter = SearchFilter(profession: profession);
    currentFilter.initTimes();
  }

  static SearchFilter getCurrentFilter() {
    return currentFilter;
  }
}
