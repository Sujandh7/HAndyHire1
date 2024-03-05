import 'package:firebase_practise/Provider/signupProvider.dart';
import 'package:firebase_practise/View/logIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../Util/String_const.dart';
import '../api/status_util.dart';
import '../custom_ui/custom_textformfield.dart';
import '../helper/helper.dart';

// ignore: must_be_immutable
class SignUp1 extends StatelessWidget {
  List<String> itemList = ["Male", "Female"];

  SignUp1({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("REGISTER"),
          backgroundColor: Colors.blue,
        ),
        body: Consumer<SignupProvider>(
          builder: (context, SignupProvider, child) => Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SingleChildScrollView(
              child: Stack(
                children: [ui(SignupProvider, context), loader(SignupProvider)],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loader(SignupProvider signUpProvider) {
    if (signUpProvider.signUpStatus == NetworkStatus.loading) {
      return Helper.backdropFilter(signUpProvider);
    } else {
      return SizedBox();
    }
  }

  Widget ui(SignupProvider signupProvider, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomForm(
            onChanged: (value) {
              signupProvider.name = value;
            },
            obscureText: false,
            labelText: nameStr,
            validator: (value) {
              if (value!.isEmpty) {
                return nameValidationStr;
              } else {
                return null;
              }
            },
            suffixIcon: const Icon(Icons.person),
          ),
          const SizedBox(
            height: 10,
          ),
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
              signupProvider.address = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return addressValidationStr;
              } else {
                return null;
              }
            },
            obscureText: false,
            labelText: addressStr,
            suffixIcon: const Icon(Icons.location_city),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomForm(
            onChanged: (value) {
              signupProvider.phone = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return contactValidationStr;
              } else {
                return null;
              }
            },
            obscureText: false,
            labelText: contactStr,
            suffixIcon: const Icon(Icons.phone),
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
          const SizedBox(
            height: 10,
          ),

//          CustomDropDown(
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return genderValidationStr;
//     } else {
//       return null;
//     }
//   },
//   icon: Icon(Icons.people),
//   decoration: InputDecoration(
//     labelText: genderStr,
//     border: OutlineInputBorder(),
//   ),
//   itemList: itemList,
//   value: signupProvider.gender,
//   onChanged: (value) {
//     signupProvider.gender = value;
//   },
// ),

         const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red.shade200,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await signupProvider.saveCredentials();
                  if (signupProvider.logInStatus == NetworkStatus.success) {
                    Helper.snackBarMessage("Registered Successfully", context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogIn()));
                  } else if (signupProvider.logInStatus ==
                      NetworkStatus.error) {
                    Helper.snackBarMessage("Registration Failed", context);
                  }
                }
              },
              child: Text(submitStr)),
        ],
      ),
    );
  }
}
