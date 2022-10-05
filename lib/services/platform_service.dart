import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

late var sim;
late var brand;
late var isNotEmu;

Future initDevice() async {
  try {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      sim = await FlutterSimCountryCode.simCountryCode;
      brand = androidInfo.brand;
      isNotEmu = androidInfo.isPhysicalDevice;
    }
    if (Platform.isIOS) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      sim = await FlutterSimCountryCode.simCountryCode;
      brand = iosDeviceInfo.utsname.machine;
      isNotEmu = iosDeviceInfo.isPhysicalDevice;
    }
  } catch (_) {
    sim = "";
    brand = "";
    isNotEmu = false;
  }
  print(brand);
  print(sim);
  print(isNotEmu);
}
