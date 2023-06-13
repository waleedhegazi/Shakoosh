import 'package:flutter/material.dart';
import 'package:test_app/Shakoosh_icons.dart';
import 'package:test_app/Assets.dart';
import 'package:test_app/repository/User_Repository.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:test_app/logged in/profile/Location_Picker.dart' as m;
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:test_app/data_models/User_Account_Model.dart';

class MyLocationScreen extends StatefulWidget {
  const MyLocationScreen({super.key});

  @override
  State<MyLocationScreen> createState() {
    return _MyLocationScreenState();
  }
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  final _cityController = TextEditingController();
  final _buildingNumberController = TextEditingController();
  final _streetController = TextEditingController();
  final _addressTitleController = TextEditingController();
  final _apartmentNumberController = TextEditingController();
  final _floorNumberController = TextEditingController();
  int index = 0;
  double screenHeight = 0;
  double screenWidth = 0;
  bool _isAddingLocation = false;
  void _deleteLocation(int index, Location deletedLocation) async {
    await UserRepository.deleteLocation(index);
    _showDeletionMessage(index, deletedLocation);
    setState(() {});
    UserRepository.updateLocationsInDatabase();
  }

  void _addLocation() async {
    final String title = _addressTitleController.text.trim();
    final String city = _cityController.text.trim();
    final String street = _streetController.text.trim();
    final String buildingNO = _buildingNumberController.text.trim();
    final String floorNO = _floorNumberController.text.trim();
    final String apartmentNO = _apartmentNumberController.text.trim();

    if (city.isEmpty ||
        street.isEmpty ||
        buildingNO.isEmpty ||
        title.isEmpty ||
        floorNO.isEmpty ||
        apartmentNO.isEmpty) {
      _showMessage("Fill other fields first");
      return;
    }

    osm.GeoPoint? pickedLocation = await m.showSimplePickerLocation(
      context: context,
      isDismissible: true,
      initCurrentUserPosition: true,
    );
    if (pickedLocation != null) {
      UserRepository.getCurrentUser().addLocation(Location(
          geo: GeoFirePoint(pickedLocation.latitude, pickedLocation.longitude),
          title: title,
          city: city,
          street: street,
          buildingNo: buildingNO,
          floorNo: floorNO,
          apartmentNo: apartmentNO));
      _cityController.clear();
      _addressTitleController.clear();
      _streetController.clear();
      _buildingNumberController.clear();
      _apartmentNumberController.clear();
      _floorNumberController.clear();

      _showMessage("Location is added");
      setState(() {
        _isAddingLocation = false;
      });
      await UserRepository.updateLocationsInDatabase();
    }
  }

  void _showDeletionMessage(
      int deletedLocationIndex, Location deletedLocation) {
    bool isClicked = false;
    showTopSnackBar(
        Overlay.of(context),
        Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(155, 59, 59, 59),
                borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              height: 50,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(ShakooshIcons.logo_transparent_black_2,
                    size: 40, color: Colors.white),
                Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text("Location is deleted",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white))),
                TextButton(
                    onPressed: () {
                      if (!isClicked) {
                        _undo(deletedLocationIndex, deletedLocation);
                        isClicked = true;
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    child: const Text(
                      "Undo",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
              ]),
            )));
  }

  void _undo(int deletedLocationIndex, Location deletedLocation) {
    UserRepository.addLocationAt(deletedLocation, deletedLocationIndex);

    setState(() {});
    UserRepository.updateLocationsInDatabase();
  }

  void _showMessage(String messege) {
    showTopSnackBar(
        Overlay.of(context),
        Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(155, 77, 72, 72),
                borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              height: 50,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(ShakooshIcons.logo_transparent_black_2,
                    size: 40, color: Colors.white),
                Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(messege,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white)))
              ]),
            )));
  }

  @override
  void dispose() {
    _addressTitleController.dispose();
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
              title: Text("Manage locations",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
            )),
        body: SizedBox(
          height: screenHeight * 0.93,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: screenHeight * 0.3, child: Assets.location),
                    (UserRepository.getCurrentUser().getLocations().length < 5)
                        ? (_isAddingLocation)
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenWidth * 0.05,
                                    horizontal: screenWidth * 0.075),
                                child: Column(
                                  children: [
                                    LocationTextField(
                                      textController: _addressTitleController,
                                      hint: "ex: Home",
                                      label: "Location title",
                                      widgetWidth: screenWidth * 0.9,
                                      limit: 30,
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
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
                                          textController:
                                              _buildingNumberController,
                                          hint: "ex: 9",
                                          label: "Building number",
                                          widgetWidth: screenWidth * 0.4,
                                          limit: 3,
                                        ),
                                        SizedBox(width: screenWidth * 0.05),
                                        LocationTextField(
                                          isNumber: true,
                                          textController:
                                              _floorNumberController,
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
                                          textController:
                                              _apartmentNumberController,
                                          hint: "ex: 24",
                                          label: "Apartment number",
                                          widgetWidth: screenWidth * 0.4,
                                          limit: 3,
                                        ),
                                        SizedBox(width: screenWidth * 0.05),
                                        InkWell(
                                          onTap: _addLocation,
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: screenWidth * 0.4,
                                            height: screenHeight * 0.08,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 245, 196, 63),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Location ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                  ],
                                ),
                              )
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isAddingLocation = true;
                                  });
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent),
                                child: const Text("Add location"))
                        : const SizedBox(),
                    UserRepository.getCurrentUser().getLocations().isEmpty
                        ? Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text("No saved locations yet"))
                        : Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: Column(children: [
                              ...UserRepository.getCurrentUser()
                                  .getLocations()
                                  .map((location) {
                                return LocationCard(
                                  onDeleteTap: _deleteLocation,
                                  index: index++,
                                  location: location,
                                );
                              })
                            ]),
                          ),
                  ]),
            ),
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
  final void Function(int index, Location) onDeleteTap;
  final int index;
  final Location location;
  const LocationCard(
      {required this.index,
      required this.location,
      required this.onDeleteTap,
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
              child: const Icon(
                Icons.pin_drop_outlined,
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
                  onDeleteTap(index, location);
                },
                icon: const Icon(Icons.delete, size: 35)),
          )
        ]),
      ),
    );
  }
}
