import 'package:billpayment/service/ui_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final uiProvider = UiServiceProvider();
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      print("11");
      print(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) async {
      print("22");
      print(e);
      await uiProvider.showToast(
          "${e.message}", Colors.redAccent, Colors.white);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) async {
      // Save the verification ID so it can be used later
      // to create a PhoneAuthCredential.
      print('Code sent to $phoneNumber');
      print("333");
      print(verificationId);
      print("444");
      print(resendToken);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // Auto retrieval timeout. This is where you can manually
      // handle the verification code if needed.
      print("5555");
      print(verificationId);
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
}
