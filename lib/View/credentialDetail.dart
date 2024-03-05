// import 'package:firebase_practise/api/status_util.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../Provider/signupProvider.dart';



//using SignupProvider

// class CredentialDetails extends StatefulWidget {
//   const CredentialDetails({super.key});

//   @override
//   State<CredentialDetails> createState() => _CredentialDetailsState();
// }

// class _CredentialDetailsState extends State<CredentialDetails> {
//   @override
//   void initState() {
//     getValue();
//     super.initState();
//   }

//   getValue() async {
//     var provider = Provider.of<SignupProvider>(context, listen: false);
//     await provider.getCredentialDataFromFirebase();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Consumer<SignupProvider>(
//             builder: (context, signupProvider, child) => signupProvider
//                         .credentialDataStatus ==
//                     NetworkStatus.success
//                 ? Column(
//                     children: [
//                       signupProvider.credentialList.isNotEmpty
//                           ? Expanded(
//                               child: ListView.builder(
//                                   itemCount:
//                                       signupProvider.credentialList.length,
//                                   itemBuilder: (context, index) {
//                                     return Card(
//                                       child: Column(
//                                         children: [
//                                           Text(
//                                               "${signupProvider.credentialList[index].id}"),
//                                           Text(
//                                               "${signupProvider.credentialList[index].email}")
//                                         ],
//                                       ),
//                                     );
//                                   }),
//                             )
//                           : Center(child: Text("No Data Available!"))
//                     ],
//                   )
//                 : signupProvider.credentialDataStatus == NetworkStatus.loading
//                     ? Center(child: CircularProgressIndicator())
//                     : Center(child: Text("Error!!"))),
//       ),
//     );
//   }
// }
