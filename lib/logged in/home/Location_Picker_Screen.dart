import 'package:flutter/material.dart';
import 'package:test_app/Shakoosh_icons.dart';
import 'package:test_app/Assets.dart';
import 'package:test_app/repository/User_Repository.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:test_app/logged in/profile/Location_Picker.dart' as m;
import 'package:test_app/repository/Worker_Repository.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:test_app/data_models/User_Account_Model.dart';
import 'package:test_app/data_models/Worker_Account_Model.dart';
import 'package:test_app/logged in/home/Search_Results.dart';
import 'package:test_app/Custom_Page_Route.dart';
import 'package:test_app/SnackBars.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() {
    return _LocationPickerState();
  }
}

class _LocationPickerState extends State<LocationPicker> {
  final _cityController = TextEditingController();
  final _buildingNumberController = TextEditingController();
  final _streetController = TextEditingController();
  final _apartmentNumberController = TextEditingController();
  final _floorNumberController = TextEditingController();

  int index = 0;
  double screenHeight = 0;
  double screenWidth = 0;

  Future<void> _chooseLocation(int index) async {
    SearchFilter.currentFilter
        .setLocation(UserRepository.getCurrentUser().getLocationAt(index));
    bool isDone = await WorkerRepository.search();
    if (isDone) {
      Navigator.of(context).push(CustomPageRoute(child: SearchResults()));
    } else {
      SnackBars.showErrorMessage(context, 'Something went wrong');
    }
  }

  void _submit() async {
    final String city = _cityController.text.trim();
    final String street = _streetController.text.trim();
    final String buildingNO = _buildingNumberController.text.trim();
    final String floorNO = _floorNumberController.text.trim();
    final String apartmentNO = _apartmentNumberController.text.trim();

    if (city.isEmpty ||
        street.isEmpty ||
        buildingNO.isEmpty ||
        floorNO.isEmpty ||
        apartmentNO.isEmpty) {
      SnackBars.showMessage(context, "Fill all of the fields first");
      return;
    }

    osm.GeoPoint? pickedLocation = await m.showSimplePickerLocation(
      context: context,
      isDismissible: true,
      initCurrentUserPosition: true,
    );
    if (pickedLocation != null) {
      SearchFilter.currentFilter.setLocation(Location(
          geo: GeoFirePoint(pickedLocation.latitude, pickedLocation.longitude),
          title: 'New',
          city: city,
          street: street,
          buildingNo: buildingNO,
          floorNo: floorNO,
          apartmentNo: apartmentNO));
      bool isDone = await WorkerRepository.search();
      if (isDone) {
        Navigator.of(context).push(CustomPageRoute(child: SearchResults()));
      } else {
        SnackBars.showErrorMessage(context, 'Something went wrong');
      }
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    _buildingNumberController.dispose();
    _streetController.dispose();
    _apartmentNumberController.dispose();
    _floorNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(context) {
    index = 0;
    screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    screenWidth = MediaQuery.of(context).size.width;

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
              title: Text("Search filters",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
            )),
        body: SizedBox(
          height: screenHeight * 0.93,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.3, child: Assets.location),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.05,
                        horizontal: screenWidth * 0.075),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            LocationTextField(
                              textController: _cityController,
                              hint: "ex: Giza",
                              label: "City",
                              widgetWidth: screenWidth * 0.4,
                              limit: 15,
                            ),
                            SizedBox(
                              width: screenWidth * 0.05,
                            ),
                            LocationTextField(
                              textController: _streetController,
                              hint: "Street name",
                              label: "Street",
                              widgetWidth: screenWidth * 0.4,
                              limit: 15,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          children: [
                            LocationTextField(
                              isNumber: true,
                              textController: _buildingNumberController,
                              hint: "ex: 9",
                              label: "Building number",
                              widgetWidth: screenWidth * 0.4,
                              limit: 3,
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            LocationTextField(
                              isNumber: true,
                              textController: _floorNumberController,
                              hint: "ex: 8",
                              label: "Floor",
                              widgetWidth: screenWidth * 0.4,
                              limit: 2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          children: [
                            LocationTextField(
                              isNumber: true,
                              textController: _apartmentNumberController,
                              hint: "ex: 24",
                              label: "Apartment number",
                              widgetWidth: screenWidth * 0.4,
                              limit: 3,
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            InkWell(
                              onTap: _submit,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                width: screenWidth * 0.4,
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 245, 196, 63),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Location ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary),
                                      ),
                                      Icon(
                                        ShakooshIcons.helmet_marker,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        size: 35,
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                      ],
                    ),
                  ),
                  UserRepository.getCurrentUser().getLocations().isEmpty
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text("No saved locations yet"))
                      : Column(children: [
                          Text('Or you can choose from your saved locations'),
                          const SizedBox(height: 20),
                          ...UserRepository.getCurrentUser()
                              .getLocations()
                              .map((location) {
                            return LocationCard(
                              onChooseTap: _chooseLocation,
                              index: index++,
                              location: location,
                            );
                          })
                        ]),
                ]),
          ),
        ));
  }
}

class LocationTextField extends StatelessWidget {
  const LocationTextField(
      {required this.widgetWidth,
      required this.hint,
      required this.limit,
      required this.label,
      required this.textController,
      this.isNumber = false,
      super.key});
  final bool isNumber;
  final TextEditingController textController;
  final double widgetWidth;
  final int limit;
  final String hint;
  final String label;

  @override
  Widget build(context) {
    return SizedBox(
      width: widgetWidth,
      child: TextField(
        keyboardType: (isNumber) ? TextInputType.number : TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        maxLength: limit,
        controller: textController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 3)),
          labelText: label,
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final void Function(int index) onChooseTap;
  final int index;
  final Location location;
  const LocationCard(
      {required this.index,
      required this.location,
      required this.onChooseTap,
      super.key});
  @override
  Widget build(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: screenWidth * 0.025, horizontal: screenWidth * 0.05),
        padding: EdgeInsets.all(screenWidth * 0.025),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              padding: EdgeInsets.only(right: screenWidth * 0.025),
              child: Icon(
                Icons.pin_drop_outlined,
                color: Theme.of(context).colorScheme.secondary,
                size: 50,
              )),
          SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(location.title,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      "City: ${location.city}\nStreet: ${location.street}\nBuilding number: ${location.buildingNo}\nFloor: ${location.floorNo}\nApartment: ${location.apartmentNo}",
                      style: Theme.of(context).textTheme.bodySmall)
                ]),
          ),
          Container(
            padding: EdgeInsets.only(left: screenWidth * 0.025),
            child: IconButton(
                onPressed: () {
                  onChooseTap(index);
                },
                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 35)),
          )
        ]),
      ),
    );
  }
}
