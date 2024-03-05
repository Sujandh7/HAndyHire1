
import 'package:firebase_practise/model/credential.dart';
import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../api/api_service_impl.dart';
import '../api/apiresponse.dart';
import '../api/status_util.dart';
class SignupProvider extends ChangeNotifier {
  String? name, address, phone, password, email;
  String? errorMessage;
  bool isUserExist = false;
  List<Credential> credentialList=[];
  NetworkStatus credentialDataStatus = NetworkStatus.idle;

  Apiservice apiservice = ApiServiceImpl();
  NetworkStatus signUpStatus = NetworkStatus.idle;
  setsignUpStatus(NetworkStatus) {
    signUpStatus = NetworkStatus;
    notifyListeners();
  }

NetworkStatus getCredentialDataStatus=NetworkStatus.idle;
  NetworkStatus logInStatus = NetworkStatus.idle;
  setlogInStatus(NetworkStatus) {
    logInStatus = NetworkStatus;
    notifyListeners();
  }

  bool showPassword = false;

  passwordVisibility(bool value) {
    showPassword = value;
    notifyListeners();
  }

  saveCredentials() async {
    if (signUpStatus != NetworkStatus.loading) {
      setsignUpStatus(NetworkStatus.loading);
    }
    Credential credential = Credential(
        address: address,
        email: email,
        name: name,
        password: password,
        phone: phone);
    ApiResponse response = await apiservice.signUp(credential);
    if (response.networkStatus == NetworkStatus.success) {
      setsignUpStatus(NetworkStatus.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      setsignUpStatus(NetworkStatus.error);
    }
  }

  loginCredentials() async {
    if (logInStatus != NetworkStatus.loading) {
      setlogInStatus(NetworkStatus.loading);
    }
    Credential credential = Credential(email: email, password: password);
    ApiResponse response = await apiservice.login(credential);
    if (response.networkStatus == NetworkStatus.success) {
      isUserExist = response.data;
      setlogInStatus(NetworkStatus.success);
    } else if (response.networkStatus == NetworkStatus.error) {
      errorMessage = response.errorMessage;
      setlogInStatus(NetworkStatus.error);
    }
  }
  setCredentialDataStatus(NetworkStatus)async
  {
     credentialDataStatus= NetworkStatus;  
    notifyListeners();
  }
  Future<void> getCredentialDataFromFirebase()async{
  if(credentialDataStatus!= NetworkStatus.loading){
    setCredentialDataStatus(NetworkStatus.loading);
  }
  ApiResponse apiResponse= await apiservice.getCredentialDataFromFirebase();

  if(apiResponse.networkStatus== NetworkStatus.success){
credentialList=apiResponse.data;
setCredentialDataStatus(NetworkStatus.success);

  }else if(apiResponse.networkStatus==NetworkStatus.error){
    errorMessage=apiResponse.errorMessage;
setCredentialDataStatus(NetworkStatus.error);
  }
}


}



// class SignupProvider extends ChangeNotifier {
//   String? name, address, contact, email, password;
//   Apiservice apiservice = ApiServiceImpl();
//   NetworkStatus signupStatus = NetworkStatus.idle;
//   String? errorMessage;
//   bool isUserExist = false;
//   bool showPassword = false;

//   setSignupStatus(NetworkStatus networkStatus) {
//     signupStatus = networkStatus;
//     notifyListeners();
//   }

//   passwordVisibility(bool value) {
//     showPassword = value;
//     notifyListeners();
//   }

//   Future<void> signUp() async {
//     if (signupStatus != NetworkStatus.loading) {
//       setSignupStatus(NetworkStatus.loading);
//     }

//     Credential credential = Credential(
//         name: name,
//         address: address,
//         phoneNo: contact,
//         email: email,
//         password: password);

//     ApiResponse response = await apiservice.signUp(credential);

//     if (response.networkStatus == NetworkStatus.success) {
//       setSignupStatus(NetworkStatus.success);
//     } else if (response.networkStatus == NetworkStatus.error) {
//       errorMessage = response.errorMessage;
//       setSignupStatus(NetworkStatus.error);
//     }
//   }

//   Future<void> login() async {
//     if (signupStatus != NetworkStatus.loading) {
//       setSignupStatus(NetworkStatus.loading);
//     }

//     Credential credential = Credential(email: email, password: password);

//     ApiResponse response = await apiservice.login(credential);

//     if (response.networkStatus == NetworkStatus.success) {
//       isUserExist = response.data;
//       setSignupStatus(NetworkStatus.success);
//     } else if (response.networkStatus == NetworkStatus.error) {
//       errorMessage = response.errorMessage;
//       setSignupStatus(NetworkStatus.error);
//     }
//   }
// }
