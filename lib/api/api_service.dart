import 'package:firebase_practise/model/credential.dart';

import 'apiresponse.dart';

abstract class Apiservice {
//  Future<ApiResponse> saveCredential(Credential credential);

  Future<ApiResponse> signUp(Credential credential);
  Future<ApiResponse> login(Credential credential);
  Future<ApiResponse>getCredentialDataFromFirebase();
  Future<ApiResponse>deleteCredentialDataFromFirebase(String id);
  Future<ApiResponse>updateCredentialDataFromFirebase(Credential credential);
}
