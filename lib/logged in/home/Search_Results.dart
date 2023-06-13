import 'package:flutter/material.dart';
import 'package:test_app/repository/Worker_Repository.dart';
import 'package:test_app/Custom_Page_Route.dart';
import 'package:test_app/logged in/home/Worker_Profile_Screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});
  @override
  State<SearchResults> createState() {
    return _SearchResultsState();
  }
}

class _SearchResultsState extends State<SearchResults> {
  double screenHeight = 0;
  double screenWidth = 0;
  int workerIndex = 0;
  void _selectWorker(int index) {
    Navigator.of(context)
        .push(CustomPageRoute(child: WorkerProfile(workerIndex: index)));
  }

  void onSortBy(int index) {
    switch (index) {
      case 0: //rate
        break;
      case 1: // price
        break;
      case 2: // experience
    }
  }

  @override
  Widget build(context) {
    screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    screenWidth = MediaQuery.of(context).size.width;
    workerIndex = 0;
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
              title: Text("Search results",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
            )),
        body: SizedBox(
          height: screenHeight * 0.92,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.7),
                  SizedBox(
                      height: screenHeight * 0.05,
                      width: screenWidth * 0.23,
                      child: DropDownOptions(onOptionTap: onSortBy)),
                ],
              ),
              SizedBox(
                  height: screenHeight * 0.87,
                  child: ListView.builder(
                      itemCount: WorkerRepository.getWorkersList().length,
                      itemBuilder: (ctx, index) {
                        return ResultCard(
                            workerIndex: workerIndex++,
                            selectWorker: _selectWorker);
                      })),
            ],
          ),
        ));
  }
}

class ResultCard extends StatelessWidget {
  final void Function(int index) selectWorker;
  final int workerIndex;
  const ResultCard(
      {required this.workerIndex, required this.selectWorker, super.key});
  @override
  Widget build(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Card(
      child: Container(
        //height: screenHeight * 0.15,
        margin: EdgeInsets.symmetric(
            vertical: screenWidth * 0.025, horizontal: screenWidth * 0.05),
        padding: EdgeInsets.all(screenWidth * 0.025),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                      width: screenHeight * 0.1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: WorkerRepository.getWorkersList()[workerIndex]
                            .getProfilePic(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white),
                          child: Icon(
                            WorkerRepository.getWorkersList()[workerIndex]
                                .getIconData(),
                            size: 15,
                            color: Colors.black87,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "${WorkerRepository.getWorkersList()[workerIndex].getFirstName()} ${WorkerRepository.getWorkersList()[workerIndex].getLastName()}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ]),
          SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                        WorkerRepository.getWorkersList()[workerIndex]
                            .getRate()
                            .toString(),
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        width: 15,
                        height: 15,
                        child: WorkerRepository.getWorkersList()[workerIndex]
                            .getStar()),
                  ]),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          WorkerRepository.getWorkersList()[workerIndex]
                              .getRaters()
                              .toString(),
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(Icons.people_alt, size: 18)
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(WorkerRepository.getWorkersList()[workerIndex]
                          .getHourlyRate()),
                      SizedBox(
                        width: 2,
                      ),
                      Text('EGP',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(Icons.av_timer_sharp)
                    ],
                  )
                ]),
          ),
          Container(
            padding: EdgeInsets.only(left: screenWidth * 0.025),
            child: TextButton(
                onPressed: () {
                  selectWorker(workerIndex);
                },
                child: Text('View profile',
                    style: Theme.of(context).textTheme.bodySmall),
                style:
                    TextButton.styleFrom(backgroundColor: Colors.transparent)),
          )
        ]),
      ),
    );
  }
}

class DropDownOptions extends StatelessWidget {
  final void Function(int option) onOptionTap;
  DropDownOptions({required this.onOptionTap, super.key});

  final optoinsList = MenuItems.menuItems;

  @override
  Widget build(context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
          'Sort by',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        items: [
          ...optoinsList.map((item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: Row(
                children: [
                  item.getOptionIcon(),
                  const SizedBox(
                    width: 10,
                  ),
                  item.getOptionText(),
                ],
              )))
        ],
        onChanged: (item) {
          if (item != null) {
            onOptionTap(item.getIndex());
          }
        },
        dropdownStyleData: DropdownStyleData(
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromARGB(255, 245, 196, 63),
          ),
          elevation: 8,
          offset: const Offset(2, 8),
        ),
      ),
    );
  }
}

class MenuItem {
  final Text optionText;
  final Icon optionIcon;
  final int index;
  const MenuItem(
      {required this.index,
      required this.optionText,
      required this.optionIcon});
  Text getOptionText() {
    return optionText;
  }

  Icon getOptionIcon() {
    return optionIcon;
  }

  int getIndex() {
    return index;
  }
}

class MenuItems {
  static const MenuItem rate = MenuItem(
      index: 0,
      optionText: Text(
        'High rate',
        style: TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
      ),
      optionIcon: Icon(Icons.star, color: Colors.black));
  static const MenuItem price = MenuItem(
      index: 1,
      optionText: Text('Low price',
          style: TextStyle(
              color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
      optionIcon: Icon(Icons.attach_money_rounded, color: Colors.black));
  static const MenuItem experience = MenuItem(
      index: 2,
      optionText: Text('Experience',
          style: TextStyle(
              color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
      optionIcon: Icon(
        Icons.work_history,
        color: Colors.black,
      ));
  static final List<MenuItem> menuItems = [rate, price, experience];
}
