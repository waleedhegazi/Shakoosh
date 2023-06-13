import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_app/data_models/User_Account_Model.dart';
import 'package:test_app/repository/Authentication_Repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

//Do database operations
class UserRepository {
  static final _db = FirebaseFirestore.instance;
  static final userId = AuthenticationRepository.auth.currentUser!.uid;

  static UserAccountModel _currentUser = Accounts.dummyAccount;
  static UserAccountModel getCurrentUser() {
    return _currentUser;
  }

  static Future updateCurrentUser() async {
    await FirebaseFirestore.instance
        .collection('service_consumer')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      _currentUser = UserAccountModel.fromJson(value.data()!);
    }).catchError((e) {
      print("Errrrrrror ${e.toString()}");
    });
  }

  static Future updateCurrentUserLocations() async {
    getCurrentUser().clearLocations();
    print("Heloooooooooooooooooooooo startttt");
    await _db
        .collection('service_consumer')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('locations')
        .get()
        .then((list) => list.docs.map((locationMap) {
              print("Heloooooooooooooooooooooo ${locationMap.data()['city']}");
              getCurrentUser()
                  .addLocation(Location.fromJson(locationMap.data()));
            }))
        .catchError((e) {
      print("Errrrrrror ${e.toString()}");
    });
    print("Heloooooooooooooooooooooo enddd");
  }

  static Future updateAll() async {
    await updateCurrentUser();
    await removeExpiredRequests();
    await removeExpiredAppointment();
  }

  static Future removeExpiredRequests() async {
    await FirebaseFirestore.instance
        .collection('request')
        .where('client_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('create_date',
            isLessThanOrEqualTo: DateTime.now()
                .subtract(Duration(days: 1))
                .millisecondsSinceEpoch)
        .get()
        .then((snapshot) {
      snapshot.docs.map((doc) {
        // notification -- > request is automatically canceled due to unresponse of the worker.
        doc.reference.delete();
      });
    });
  }

  static Future removeExpiredAppointment() async {
    await FirebaseFirestore.instance
        .collection('appointment')
        .where('client_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('create_date',
            isLessThanOrEqualTo: DateTime.now()
                .subtract(Duration(hours: 1, minutes: 30))
                .millisecondsSinceEpoch)
        .get()
        .then((snapshot) {
      snapshot.docs.map((doc) {
        //notification --> rate the appointment and give review.
        doc.reference.delete();
      });
    });
  }

  static Future<bool> createUser(UserAccountModel user) async {
    bool isCreated = await AuthenticationRepository.createUser(user);
    return isCreated;
  }

  static Future<void> addProfilePic(File image) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("user_images")
        .child("$userId.jpg");
    await storageRef.putFile(image);
    final imageURL = await storageRef.getDownloadURL();
    getCurrentUser().setProfilePicURL(imageURL);
    getCurrentUser().setProfilePic(imageURL);
    await _db
        .collection('service_consumer')
        .doc(userId)
        .update({'profile_pic_url': imageURL});
  }

  static Future<void> removeProfilePic() async {
    getCurrentUser().setProfilePicURL(null);
    await FirebaseStorage.instance
        .ref()
        .child("user_images")
        .child("$userId.jpg")
        .delete();
    await _db
        .collection('service_consumer')
        .doc(userId)
        .update({'profile_pic_url': null});
  }

  static addLocation(Location locationData) {
    getCurrentUser().addLocation(locationData);
  }

  static addLocationAt(Location locationData, int index) {
    getCurrentUser().addLocationAt(locationData, index);
  }

  static deleteLocation(int index) {
    getCurrentUser().deleteLocation(index);
  }

  static Future<void> updateLocationsInDatabase() async {
    await _db.collection('service_consumer').doc(userId).update({
      'locations': getCurrentUser().getLocations().map((location) {
        return location.toJson();
      }).toList()
    });
  }

  static Future<void> updateProfileInfoInDatabase() async {
    await _db.collection('service_consumer').doc(userId).update({
      'first_name': getCurrentUser().getFirstName(),
      'last_name': getCurrentUser().getLastName(),
      'email': getCurrentUser().getEmail(),
      'password': getCurrentUser().getPassword(),
      'phone_number': getCurrentUser().getPhoneNumber()
    });
  }
}
