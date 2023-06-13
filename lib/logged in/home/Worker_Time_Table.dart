import 'package:flutter/material.dart';
import 'package:test_app/Assets.dart';
import 'package:intl/intl.dart';
import 'package:test_app/data_models/Worker_Account_Model.dart';
import 'package:test_app/register/Register_Next_Button.dart';
import 'package:test_app/repository/User_Repository.dart';
import 'package:test_app/repository/Worker_Repository.dart';
import 'package:test_app/Dialogs.dart';
import 'package:test_app/SnackBars.dart';
import 'package:test_app/data_models/Request_Model.dart';

class WorkerTimePicker extends StatefulWidget {
  final int workerIndex;
  const WorkerTimePicker({required this.workerIndex, super.key});
  @override
  State<WorkerTimePicker> createState() {
    return _WorkerTimePickerState();
  }
}

class _WorkerTimePickerState extends State<WorkerTimePicker> {
  int daysStartFrom = 0;
  int canceledTimes = 0;
  List<bool> timeTable = [];
  int selectedIndex = -1;

  @override
  void initState() {
    for (int i = 0; i < 56; i++) {
      timeTable.add(WorkerRepository.getWorkersList()[widget.workerIndex]
          .getTimeTableAt(i));
    }
    var now = DateTime.now();
    String day = DateFormat('EEEE').format(now).toString();
    int hour = int.parse(DateFormat('H').format(now));
    if (hour > 19) {
      canceledTimes = 8;
    } else if (hour > 17) {
      canceledTimes = 7;
    } else if (hour > 16) {
      canceledTimes = 6;
    } else if (hour > 14) {
      canceledTimes = 5;
    } else if (hour > 13) {
      canceledTimes = 4;
    } else if (hour > 11) {
      canceledTimes = 3;
    } else if (hour > 10) {
      canceledTimes = 2;
    } else if (hour > 8) {
      canceledTimes = 1;
    }
    switch (day) {
      case 'Sunday':
        daysStartFrom = 1;
        break;
      case 'Monday':
        daysStartFrom = 2;
        break;
      case 'Tuesday':
        daysStartFrom = 3;
        break;
      case 'Wednesday':
        daysStartFrom = 4;
        break;
      case 'Thursday':
        daysStartFrom = 5;
        break;
      case 'Friday':
        daysStartFrom = 6;
        break;
    }
    super.initState();
  }

  void _onSubmitRequest(BuildContext context) {
    if (selectedIndex == -1) {
      SnackBars.showMessage(context, 'Please pick time first');
      return;
    }
    Dialogs.showCustomizedTextFieldDialog(
        context,
        _book,
        'Give a detailed description',
        Assets.getHintText(WorkerRepository.getWorkersList()[widget.workerIndex]
            .getProfession()),
        'Submit',
        'Cance');
  }

  Future<void> _book(String details) async {
    RequestModel req = RequestModel(
        id: 'id',
        clientId: UserRepository.getCurrentUser().getId(),
        workerId: WorkerRepository.getWorkersList()[widget.workerIndex].getId(),
        location: SearchFilter.getCurrentFilter().getLocation(),
        requestDate: getTimeFromSpot(selectedIndex),
        createDate: DateTime.now(),
        details: details);
    bool isDone = await WorkerRepository.submitRequestToDatabase(req);
    if (isDone) {
      SnackBars.showMessage(context, 'Request has been sent');
      int count = 0;
      Navigator.popUntil(context, (route) {
        return count++ == 4;
      });
      Navigator.pop(context);
    } else {
      SnackBars.showErrorMessage(context, 'Something went wrong');
    }
  }

  DateTime getTimeFromSpot(int index) {
    int days = (index / 8).floor();
    int daySpotIndex = index % 8;
    int hours = 9 + (daySpotIndex * (3 / 2)).floor();
    int minutes = (daySpotIndex % 2 == 0) ? 0 : 30;
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    return today.add(Duration(days: days, hours: hours, minutes: minutes));
  }

  Widget spotsGrid(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int count = canceledTimes;
    int canceledTimesCount = 0;
    return GridView(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          crossAxisSpacing: screenWidth * 0.02,
          mainAxisSpacing: screenWidth * 0.02,
        ),
        children: WorkerRepository.getWorkersList()[widget.workerIndex]
            .getTimeTable()
            .map((isUnavailable) {
          if (canceledTimesCount++ < canceledTimes) {
            return canceledSpot(screenWidth * 0.085);
          } else if (isUnavailable) {
            return canceledSpot(screenWidth * 0.085);
          } else {
            return spot(screenWidth * 0.085, count++);
          }
        }).toList());
  }

  Widget canceledSpot(double dimenssion) {
    return Container(
      width: dimenssion,
      height: dimenssion,
      decoration: BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0),
          borderRadius: BorderRadius.circular(3),
          border:
              Border.all(width: 2, color: Color.fromARGB(255, 221, 220, 220))),
    );
  }

  Widget spot(double dimenssion, int index) {
    if (selectedIndex == index) {
      return InkWell(
          child: Container(
            width: dimenssion,
            height: dimenssion,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 196, 63),
                borderRadius: BorderRadius.circular(3)),
          ),
          onTap: () {
            selectedIndex = -1;
            setState(() {});
          });
    } else {
      return InkWell(
          child: Container(
            width: dimenssion,
            height: dimenssion,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 221, 220, 220),
                borderRadius: BorderRadius.circular(3)),
          ),
          onTap: () {
            selectedIndex = index;
            setState(() {});
          });
    }
  }

  List<Widget> getDays() {
    List<Widget> daysList = [FittedBox(child: Text('Tod'))];
    for (int i = daysStartFrom + 1; i < daysStartFrom + 7; i++) {
      daysList.add(FittedBox(child: Text(Assets.days[i])));
    }
    return daysList;
  }

  @override
  Widget build(context) {
    double screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.07),
            child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  )),
              title: Text("Date and time",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
            )),
        body: SingleChildScrollView(
          child: Container(
              height: screenHeight * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text("Pick the appointment date and time",
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 20),
                  Row(children: [
                    SizedBox(width: screenWidth * 0.1),
                    Container(
                      width: 0.085 * screenWidth,
                      height: 0.085 * screenWidth,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 220, 220),
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    Text(
                      "  ${WorkerRepository.getWorkersList()[widget.workerIndex].getFirstName()}'s available time",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ]),
                  SizedBox(height: screenWidth * 0.02),
                  Row(children: [
                    SizedBox(
                      width: screenWidth * 0.1,
                    ),
                    Container(
                      width: 0.085 * screenWidth,
                      height: 0.085 * screenWidth,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(0, 0, 0, 0),
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 221, 220, 220))),
                    ),
                    Text(
                      "  Unavailable time",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ]),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      SizedBox(width: screenWidth * 0.1),
                      SizedBox(
                        width: screenWidth * 0.82,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              Assets.dayTimes,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(children: [
                    Container(
                        padding:
                            EdgeInsets.only(right: 2, left: screenWidth * 0.03),
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.68,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ...getDays(),
                            ])),
                    SizedBox(
                        width: screenWidth * 0.82,
                        height: screenWidth * 0.715,
                        child: spotsGrid(context))
                  ]),
                  SizedBox(height: 60),
                  NextButton(
                      title: 'Proceed',
                      onTap: () {
                        _onSubmitRequest(context);
                      })
                ],
              )),
        ));
  }
}
