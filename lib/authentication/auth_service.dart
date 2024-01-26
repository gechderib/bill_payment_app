import 'package:billpayment/service/ui_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  String verification_id = "";
  String smsCode = "";
  bool isVerificationSuccessfull = false;
  bool isForgotPass = true;
  final uiProvider = UiServiceProvider();
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await uiProvider.showToast("Verification successfully completed",
          Colors.greenAccent, Colors.white);
      return;
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) async {
      await uiProvider.showToast(
          "${e.message}", Colors.redAccent, Colors.white);
      return;
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) async {
      verification_id = verificationId;

      await uiProvider.showToast("Verification send please check you sms",
          Colors.greenAccent, Colors.white);
      notifyListeners();
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      verification_id = verificationId;
      print(verificationId);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+$phoneNumber",
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
    notifyListeners();
  }

  Future<void> verifySms() async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verification_id,
        smsCode: smsCode,
      );

      UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = authResult.user;

      if (user != null) {
        isVerificationSuccessfull = true;
        await uiProvider.showToast(
            "Phone successfully verified", Colors.greenAccent, Colors.white);
      } else {
        isVerificationSuccessfull = false;
        await uiProvider.showToast(
            "phone number not verified", Colors.redAccent, Colors.white);
      }
    } catch (e) {
      isVerificationSuccessfull = false;
      await uiProvider.showToast(
          "phone number not verified", Colors.redAccent, Colors.white);
    }
  }
}
