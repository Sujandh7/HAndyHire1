import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_practise/Provider/signupProvider.dart';
import 'package:firebase_practise/View/logUp.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  
  
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    NotificationSetting();
    listenNotification();
    
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    




    return MultiProvider(
      providers:[
        ChangeNotifierProvider<SignupProvider>(
            create: (_) => SignupProvider()),
        // ChangeNotifierProvider<SignupProvider>(
        //     create: (_) => SignupProvider()),

            
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:logUp()
      ),
    );
  }

  NotificationSetting()async{
    NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);

print('User granted permission: ${settings.authorizationStatus}');
  }

 listenNotification(){
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(message);
  
});
 }

 getToken()async{
  String? token=await messaging.getToken();
 }
}

