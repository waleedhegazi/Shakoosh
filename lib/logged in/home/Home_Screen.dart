import 'package:flutter/material.dart';
import 'package:test_app/Assets.dart';
import 'package:test_app/logged in/home/Home_Option_Card.dart';
import 'package:test_app/logged in/home/Time_Picker_Screen.dart';
import 'package:test_app/Custom_Page_Route.dart';
import 'package:test_app/data_models/Worker_Account_Model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int choice = 0;
  int index = 0;
  double screenHeight = 0;
  double screenWidth = 0;

  void _onTap(int choice) {
    switch (choice) {
      case 0:
        SearchFilter.createFilter('Carpenter');
        Navigator.of(context).push(CustomPageRoute(child: TimePicker()));
        break;
      case 1:
        SearchFilter.createFilter('Plumber');
        Navigator.of(context).push(CustomPageRoute(child: TimePicker()));
        break;
      case 2:
        SearchFilter.createFilter('Bricklayer');
        Navigator.of(context).push(CustomPageRoute(child: TimePicker()));
        break;
      case 3:
        SearchFilter.createFilter('Painter');
        Navigator.of(context).push(CustomPageRoute(child: TimePicker()));
        break;
      case 4:
        SearchFilter.createFilter('Electrician');
        Navigator.of(context).push(CustomPageRoute(child: TimePicker()));
    }
  }

  @override
  Widget build(context) {
    screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    screenWidth = (MediaQuery.of(context).size.width);

    index = 0;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.07),
            child: AppBar(
              title: SizedBox(
                width: screenWidth,
                child: Text("Home",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            )),
        body: SizedBox(
          height: screenHeight * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.14,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Quality',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color:
                                        const Color.fromARGB(255, 245, 196, 63),
                                    fontSize: 40)),
                        SizedBox(width: 35),
                        Text('.. Never',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 25)),
                      ],
                    ),
                    Text('                   Compromised',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 25)),
                  ],
                ),
              ),
              ...Assets.homeOptionCardAssets.map((optionAsset) {
                return SizedBox(
                  height: screenHeight * 0.14,
                  child: HomeOptionCard(
                      optionAsset: optionAsset, index: index++, onTap: _onTap),
                );
              })
            ],
          ),
        ));
  }
}
