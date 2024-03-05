import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practise/View/signUp1.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpCode extends StatefulWidget {
  String? verificationId, phoneNumber;

  OtpCode({Key? key, this.phoneNumber, this.verificationId}) : super(key: key);

  @override
  State<OtpCode> createState() => _OtpCodeState();
}

class _OtpCodeState extends State<OtpCode> {
  String code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Code Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "we have send 6 digit code to ${widget.phoneNumber}",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: (value) {
                code = value;
                // Handle OTP code changes
                print('Current OTP: $value');
              },
              onCompleted: (value) {
                // Handle OTP code submission
                print('Completed OTP: $value');
              },
              textStyle: TextStyle(fontSize: 20),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                verifyOtp();

                // Handle OTP submission logic here
                // Access the entered OTP using your preferred logic
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  verifyOtp() async { print('Verifying OTP...');
    try{
     
      String smsCode = code;

      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId!, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('Before Navigator.push');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUp1(),
          ));
      

      //OR


    //    String smsCode = code;
    //    if (widget.verificationId != null) {
    //   // Create a PhoneAuthCredential with the code
    //   PhoneAuthCredential credential =
    //       PhoneAuthProvider.credential(verificationId: widget.verificationId!, smsCode: smsCode);

    //   // Sign the user in (or link) with the credential
    //   await FirebaseAuth.instance.signInWithCredential(credential);

    //   // Navigate to the SignUp page by popping the current screen
    //   // and pushing the SignUp screen
    //   print('Before Navigator.push');
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn(),));
    //   print('Verification ID is null');
    //  // Handle the case where verificationId is null


    //    }
    } catch (e) {
  print('Error verifying OTP: $e');
  showSnackbar('Invalid Otp. Please try again.');
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
