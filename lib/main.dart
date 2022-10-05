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
  await WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String? path = prefs.getString('bannerUrl');
  await initDevice();
  if (path == null || path == "") {
    if (isNotEmu == false || brand.contains('google') || sim.isEmpty) {
      print("1 рубеж не пройдет");
      runApp(const Plug());
    } else {
      print("1 рубеж пройдет");
      await Firebase.initializeApp();
      runApp(const MyApp());
    }
  } else {
    print("2 рубеж пройдет");
    if (path == "") {
      runApp(const Plug());
    } else {
      runApp(WebViewPage(
        url: path,
      ));
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RemoteConfigService remoteConfigService = RemoteConfigService();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Мелбет",
      routes: {
        '/plug': (context) => const Plug(),
        '/plug/plan': (context) => const Plug(),
      },
      home: FutureBuilder<FirebaseRemoteConfig>(
        future: remoteConfigService.setupRemoteConfig(),
        builder: (BuildContext context,
            AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Image(
                      image: AssetImage(
                        "assets/icon.png",
                      ),
                      width: 80,
                      height: 80,
                    ),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          print(snapshot.requireData.getString('url'));
          if (snapshot.requireData.getString('url') == "") {
            return const Plug();
          } else {
            setBannerUrl(snapshot.requireData.getString('url'));
          }
          return snapshot.hasData
              ? WebViewScreen(remoteConfig: snapshot.requireData)
              : const Plug();
        },
      ),
    );
  }
}

Future getBannerUrl() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.getString('bannerUrl');
}

Future setBannerUrl(String url) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('bannerUrl', url) as String;
}
