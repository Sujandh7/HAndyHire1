import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practise/api/status_util.dart';
import 'package:firebase_practise/model/credential.dart';

import 'api_service.dart';
import 'apiresponse.dart';

class ApiServiceImpl extends Apiservice {
  bool isUserExist = false;
  @override
  Future<ApiResponse> signUp(Credential credential) async {
    try {
      await FirebaseFirestore.instance
          .collection("credential")
          .add(credential.toJson());
      return ApiResponse(networkStatus: NetworkStatus.success);
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMessage: e.toString());
    }
  }

  @override
  Future<ApiResponse> login(Credential credential) async {
    try {
      await FirebaseFirestore.instance
          .collection("credential")
          .where("email", isEqualTo: credential.email)
          .where("password", isEqualTo: credential.password)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          isUserExist = true;
        } else {
          isUserExist = false;
        }
      });
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMessage: e.toString());
    }

    return ApiResponse(networkStatus: NetworkStatus.success, data: isUserExist);
  }

  @override
  Future<ApiResponse> getCredentialDataFromFirebase() async {
    List<Credential> credentialList =
        []; //object form ma convert vayeko credentialList ma basxa
    try {
      var response =
          await FirebaseFirestore.instance.collection("credential").get();
      final credential = response
          .docs; //firebase ko collection ma vako whole documents credential variable ma basxa
      if (credential.isNotEmpty) {
        for (var user in credential) {
          credentialList.add(Credential.fromJson(user.data()));
          Credential credential=Credential.fromJson(user.data());
          credential.id=user.id;
         // credentialList.add(credential);
        }

        return ApiResponse(
            networkStatus: NetworkStatus.success, data: credentialList);
      } else {
        return ApiResponse(
            networkStatus: NetworkStatus.success, data: credentialList);
      }
    } catch (e) {
      return ApiResponse(
          networkStatus: NetworkStatus.error, errorMessage: e.toString());
    }
  }

  @override
  Future<ApiResponse> deleteCredentialDataFromFirebase(String id) async {
   // String userId = await findUserByPhoneNumber(phoneNo);
    try {
      await FirebaseFirestore.instance
          .collection("credential")
          .doc(id)
          .delete();
      return ApiResponse(networkStatus: NetworkStatus.success, data: true);
    } catch (e) {
      return ApiResponse(networkStatus: NetworkStatus.error, data: false);
    }
  }

  Future<String> findUserByPhoneNumber(String Phone) async {
    var response = await FirebaseFirestore.instance
        .collection("credential")
        .where("phoneNo", isEqualTo: Phone)
        .get();
    if (response.docs.isNotEmpty) {
      var user = response.docs.first;
      return user.id;
    }
    return "";
  }

  @override
  Future<ApiResponse> updateCredentialDataFromFirebase(
      Credential credential) async {
   // String userId = await findUserByPhoneNumber(credential.phoneNo!);
    try {
      await FirebaseFirestore.instance
          .collection("credential")
          .doc(credential.id)
          .update(credential.toJson());
      return ApiResponse(networkStatus: NetworkStatus.success, data: true);
    } catch (e) {
      return ApiResponse(networkStatus: NetworkStatus.error, data: false);
    }
  }
}
