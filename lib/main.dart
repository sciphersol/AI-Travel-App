import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/onboarding_screens/onboarding_pages.dart';

import 'onboarding_screens/splash_screen.dart';


void main() async{


  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(  const ProviderScope(
    child: MaterialApp(

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  ));
}

