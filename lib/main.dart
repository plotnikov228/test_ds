import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_ex_ds/screens/web_view_screen.dart';
import 'package:test_ex_ds/services/platform_service.dart';
import 'package:test_ex_ds/services/remote_config_service.dart';
import 'package:test_ex_ds/widgets/plug_stopwatch.dart';

import 'screens/plug.dart';



void main() async {
  String path = "";
  path = getBannerUrl().toString();
  if(path.isEmpty) {
    PlatformService platformService = PlatformService();
    platformService.deviceInfo();
    if(platformService.isNotEmu == false || platformService.brand.contains('google') || platformService.sim.isEmpty) {
      runApp(const Plug());

    } else {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          name: "untitled13",
          options: FirebaseOptions(
              apiKey: 'AIzaSyDOImPs7Ia6BB9AecMZLxDXoWKUUha62rk',
              appId: checkPlatformForAppId(),
              messagingSenderId: '295045674034',
              projectId: 'test-exercise-1facb',
              storageBucket: 'test-exercise-1facb.appspot.com'));
      runApp(const MyApp());
    }
  }
  else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RemoteConfigService remoteConfigService = RemoteConfigService();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Remote Config",
      routes: {
        '/plug': (context) => const Plug(),
        '/plug/stopwatch': (context) => const PlugStopwatch(),
        '/plug/plan': (context) => const Plug(),
      },
      home: FutureBuilder<FirebaseRemoteConfig>(
        future: remoteConfigService.setupRemoteConfig(),
        builder: (BuildContext context,
            AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold( body: Center(
              child: CircularProgressIndicator(),
            ));
          }
          return snapshot.hasData
              ? WebViewScreen(remoteConfig: snapshot.requireData)
              : const Plug();
        },
      ),
    );
  }
}

String checkPlatformForAppId() {
  if (Platform.isAndroid) {
    return '1:295045674034:android:cea24873a88bbedda7f82b';
  } else {
    return '1:295045674034:ios:1dd5ea99279f6e6da7f82b';
  }
}

Future getBannerUrl () async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.getString('bannerUrl');
}

Future setBannerUrl (String url) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('bannerUrl', url) as String;
}
