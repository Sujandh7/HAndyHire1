import 'package:firebase_practise/View/homePage.dart';
import 'package:firebase_practise/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/signupProvider.dart';
import '../Util/String_const.dart';
import '../api/status_util.dart';
import '../custom_ui/custom_textformfield.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: Text("Please LogIn")),

        body: Consumer<SignupProvider>(
          builder: (context, SignupProvider, child) => Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  LoginUi(SignupProvider, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget LoginUi(SignupProvider signupProvider, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomForm(
            onChanged: (value) {
              signupProvider.email = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return emailValidationStr;
              } else {
                return null;
              }
            },
            obscureText: false,
            labelText: emailStr,
            suffixIcon: const Icon(Icons.email),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomForm(
              onChanged: (value) {
                signupProvider.password = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return passwordValidationStr;
                } else {
                  return null;
                }
              },
              labelText: passwordStr,
              obscureText: signupProvider.showPassword ? false : true,
              suffixIcon: signupProvider.showPassword
                  ? IconButton(
                      onPressed: () {
                        signupProvider.passwordVisibility(false);
                      },
                      icon: const Icon(Icons.visibility))
                  : IconButton(
                      onPressed: () {
                        signupProvider.passwordVisibility(true);
                      },
                      icon: const Icon(Icons.visibility_off))),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red.shade200,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
               await signupProvider.loginCredentials().then((value) {
                    if (signupProvider.logInStatus == NetworkStatus.success && signupProvider.isUserExist) {

                        Helper.snackBarMessage("Successfully Logged in", context);
                                Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage()));
                        
                        //navigate to dashboard
                      }else if(signupProvider.logInStatus==NetworkStatus.success && !signupProvider.isUserExist){
                        Helper.snackBarMessage("Invalid Credential!!!", context); 
                      }
                      
                      else if(signupProvider.logInStatus==NetworkStatus.error){
                        Helper.snackBarMessage("Failed to saved", context);
                      }
                      }

                  );
                  
                }


                
              },
              child: Text(loginStr)),




        ],
      ),
    );
  }
}


