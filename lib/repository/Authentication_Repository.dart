import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:test_app/data_models/User_Account_Model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_app/repository/User_Repository.dart';

class AuthenticationRepository {
  static final auth = FirebaseAuth.instance;
  static late final Rx<User?> firebaseUser;
  static final verificationId = ''.obs;
  static var userCredential;

  static Future<String?> phoneAuthentication(String phoneNumber) async {
    String? error;

    await auth
        .verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == "invalid-phone-number") {
          error = "invalid-phone-number";
        } else {
          error = "Something went wrong. Try again";
        }
      },
      codeSent: (verificationIdx, resendToken) {
        verificationId.value = verificationIdx;
      },
      codeAutoRetrievalTimeout: (verificationIdx) {
        //return "Time is out!";
      },
    )
        .then((_) {
      return error;
    }).catchError((e) {
      return "Something went wrong. Try again";
    });
    return error;
  }

  static Future<bool> verifyOTP(String otp) async {
    var credentials = await auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  static Future<bool> createUser(UserAccountModel newUser) async {
    bool check = true;
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      UserCredential newUserCredential =
          await FirebaseAuth.instanceFor(app: app)
              .createUserWithEmailAndPassword(
                  email: newUser.email, password: newUser.password);
      await FirebaseFirestore.instance
          .collection("service_consumer")
          .doc(newUserCredential.user!.uid)
          .set(newUser.toJson());
      await FirebaseFirestore.instance
          .collection("service_consumer")
          .doc(newUserCredential.user!.uid)
          .update({'id': newUserCredential.user!.uid});
    } on FirebaseAuthException catch (e) {
      check = false;
    }
    await app.delete();
    return check;
  }

  static Future<String?> signIn(String email, String password) async {
    String? error;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        error = "Incorrect email or password";
      } else if (e.code == "wrong-password") {
        error = "Wrong password";
      } else {
        error = "Something went wrong. Try again";
      }
    }
    return error;
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Future<String> checkIfEmailIsInUse(String email) async {
    try {
      final list = await auth.fetchSignInMethodsForEmail(email);
      if (list.isNotEmpty) {
        return "E-mail already exists";
      } else {
        return "Availble";
      }
    } catch (e) {
      return "An unknown error occurred";
    }
  }
}
