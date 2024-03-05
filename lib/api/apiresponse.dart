

import 'package:firebase_practise/api/status_util.dart';

class ApiResponse{
dynamic data;
String? errorMessage;
NetworkStatus? networkStatus;

ApiResponse({this.data,this.errorMessage,this.networkStatus});


}