import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      // This callback will be called on successful verification.
      // You can use the credential to sign in the user.
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      // Handle the verification failure, for example, display an error message.
      print('Verification failed: ${e.message}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? resendToken) async {
      // Save the verification ID so it can be used later
      // to create a PhoneAuthCredential.
      print('Code sent to $phoneNumber');
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // Auto retrieval timeout. This is where you can manually
      // handle the verification code if needed.
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
