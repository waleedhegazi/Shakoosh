import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_app/data_models/Worker_Account_Model.dart';
import 'package:test_app/repository/Authentication_Repository.dart';
//import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:intl/intl.dart';
import 'package:test_app/Assets.dart';
import 'package:test_app/data_models/Request_Model.dart';

class WorkerRepository {
  static final _db = FirebaseFirestore.instance;
  static final userId = AuthenticationRepository.auth.currentUser!.uid;
  static final geo = GeoFlutterFire();

  static List<Worker> _workersList = [workerEx];
  static List<Worker> getWorkersList() {
    return _workersList;
  }

  static Future<bool> search() async {
    //_workersList.clear();
    bool isDone = false;
    GeoFirePoint center = SearchFilter.getCurrentFilter().getLocation().geo;
    try {
      var collectionReference = FirebaseFirestore.instance
          .collection('service_provider')
          .where('profession',
              isEqualTo: SearchFilter.getCurrentFilter().profession)
          .where('is_active', isEqualTo: true);

      Stream<List<DocumentSnapshot>> stream = geo
          .collection(collectionRef: collectionReference)
          .within(center: center, radius: 10, field: 'location');

      stream.forEach((element) {
        element.forEach((e) {
          double lat = e.get('location')['geo']['geopoint'].latitude;
          double lng = e.get('location')['geo']['geopoint'].longitude;

          if (center.distance(lat: lat, lng: lng) < 10) {
            _workersList.add(Worker.fromJson(e.data() as Map<String, dynamic>));
          }
        });
      });
      isDone = true;
    } catch (e) {
      isDone = false;
    }
    return isDone;
  }

  static Future<bool> submitRequestToDatabase(RequestModel req) async {
    bool isDone = false;
    try {
      await _db
          .collection('request')
          .doc()
          .set(req.toJson())
          .whenComplete(() => isDone = true);
    } catch (e) {
      return false;
    }

    return isDone;
  }
}

Worker workerEx = Worker(
    id: "",
    firstName: "Hassan",
    lastName: "Ali",
    email: "HassanAli@gmail.com",
    phoneNumber: "01101601978",
    creationDate: (DateFormat.yMMMd().format(DateTime.now())).toString(),
    profilePicURL: "",
    rate: 3.2,
    raters: 43,
    location: {},
    hourlyRate: '50',
    profilePic: Assets.anonymousImage,
    profession: 'Carpenter',
    timeTable: [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      true,
      true,
      true,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      true,
      true,
      true,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      true,
      true,
      true,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ]);
