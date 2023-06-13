import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_app/Shakoosh_icons.dart';

class Assets {
  static Image anonymousImage =
      Image.asset("assets/images/anonymous_profile_pic.png");
  static SvgPicture location_grey =
      SvgPicture.asset("assets/images/location_marker_grey.svg");
  static Image location = Image.asset("assets/images/location.png");

  static String dayTimes =
      '09:00    10:30    12:00    01:30    03:00    04:30    06:00    07:30\n    -            -            -           -            -            -           -           -    \n10:30    12:00    01:30    03:00    04:30    06:00    07:30    09:00';
  static List<String> days = [
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri'
  ];

  static List<HomeOptionCardAssets> homeOptionCardAssets = const [
    HomeOptionCardAssets(
        title: 'Carpenter',
        describtion: 'Construct, repair and install a wooden object?',
        iconData: ShakooshIcons.carpenter),
    HomeOptionCardAssets(
        title: 'Plumber',
        describtion:
            'Need to maintain your plumbing fixtures or install a new one?',
        iconData: ShakooshIcons.plumber),
    HomeOptionCardAssets(
        title: 'Construction Worker',
        describtion: 'Book an appointment with a professional bricklayer',
        iconData: ShakooshIcons.bricklayer),
    HomeOptionCardAssets(
        title: 'Painter & Decorator',
        describtion: 'Paint your house with a skillful painter',
        iconData: ShakooshIcons.decorator),
    HomeOptionCardAssets(
      title: 'Electrician',
      describtion:
          'Repair and install electrical units with experinced electricians',
      iconData: ShakooshIcons.electricain,
    )
  ];

  static String getHintText(String profession) {
    switch (profession) {
      case 'Carpenter':
        return 'ex: I want to install a couple of new windows. And install one wooden room door.';
      case 'Plumber':
        return 'ex: I want to install a new water filter. And repair a cracked pipe in the kitchen.';
      case 'Electrician':
        return 'ex: I need to maintain my lighting system. And install some electrical components.';
      case 'Painter':
        return 'ex: I want to paint my apartment walls. And I need to decorate my ceiling.';
      case 'Bricklayer':
        return 'ex: I want to build a wall in the dinning room to split it into two rooms.';
    }
    return '';
  }

  static List<SvgPicture> ratingStarsImages = [
    SvgPicture.asset("assets/images/star_0.svg"),
    SvgPicture.asset("assets/images/star_1.svg"),
    SvgPicture.asset("assets/images/star_2.svg"),
    SvgPicture.asset("assets/images/star_3.svg"),
    SvgPicture.asset("assets/images/star_4.svg"),
    SvgPicture.asset("assets/images/star_5.svg"),
    SvgPicture.asset("assets/images/star_empty.svg")
  ];
}

class HomeOptionCardAssets {
  final String title;
  final String describtion;
  final IconData iconData;
  const HomeOptionCardAssets(
      {required this.title, required this.describtion, required this.iconData});
  String getTitle() {
    return title;
  }

  String getDescribtion() {
    return describtion;
  }

  IconData getIconData() {
    return iconData;
  }
}
