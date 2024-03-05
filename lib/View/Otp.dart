

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practise/View/OtpCode.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String? phoneCode = "+977";

  String? phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          TextFormField(
            onChanged: (value) {
              phoneNumber = value;
            },
            decoration: InputDecoration(
                labelText: "phone",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(onPressed: () {
            sendVerificationCode( context);
          }, child: Text("Submit"))
        ],
      ),
    );
  }

  sendVerificationCode(context) async {
   try{ await FirebaseAuth.instance.verifyPhoneNumber(
    timeout: Duration(seconds: 119), 
      phoneNumber: phoneCode! + phoneNumber!,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
       if (e.code == 'invalid-verification-code') {
          // Invalid verification code (OTP is incorrect), show a Snackbar
          showSnackbar('Invalid OTP. Please try again.');
        } else {
          // Handle other verification failures (e.g., SMS sending failure) here
          print('Verification failed with error code: ${e.code}');
        }
       
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpCode(
                 phoneNumber: phoneNumber,
        verificationId: verificationId,
              ),

              
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );}
    catch(e){
      
    }
  }
  void showSnackbar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ),
  );
}}
