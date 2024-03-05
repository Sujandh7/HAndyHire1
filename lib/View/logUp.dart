import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practise/View/OtpCode.dart';
import 'package:firebase_practise/View/logIn.dart';
import 'package:firebase_practise/custom_ui/CustomElevatedButton.dart';
import 'package:firebase_practise/custom_ui/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Util/String_const.dart';

class logUp extends StatefulWidget {
  logUp({super.key});

  @override
  State<logUp> createState() => _logUpState();
}

class _logUpState extends State<logUp> {
  String? phoneCode = "+977";
  String? phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45, top: 300),
            child: Text(
              "Enter your phone Number",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              "We will send you a confirmation code",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 120),
            child: Text(
              "Phone Number",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 23),
            width: 350,
            child: CustomForm(
              obscureText: false,

              hintText: "Enter phone number",
              keyboardType: TextInputType.phone,
              prefixIcon: Icon(Icons.phone_android),
              onChanged: (value) {
                phoneNumber = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return contactValidationStr;
                } else if (value.length != 10) {
                  return passwordlengthStr;
                } else {
                  return null;
                }
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 45,
              width: 350,
              child: CustomElevatedButton(

                onprimary: Colors.white,
                primary: colorstr,
                onPressed: () {
                  sendVerificationCode(context);
                },
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: colorstr,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    " Sign in with",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color:colorstr,
                    thickness: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: colorstr,
                  onPrimary: Colors.white),
              onPressed: () {
                GoogleLogin(context);
              },
              child: SizedBox(
                height: 40,
                width: 220,
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.google),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Login with google",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ))


        ],
      ),
    );
  }

  GoogleLogin(BuildContext context) async {
    String? token;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;

        print(user!.phoneNumber);

        //to get token
        // var token =await user.getIdToken();
        // print(token);
        //or

        await user.getIdToken().then((value) {
          token = value;
          print(token);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
      if (token != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LogIn(),
            ));
      }
    }
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
  }
}
