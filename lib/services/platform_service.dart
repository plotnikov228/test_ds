import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:sim_info/sim_info.dart';

class PlatformService {

  late String brand;
  late bool isNotEmu;
  late String model;
  late String sim;

  Future<FutureOr> deviceInfo () async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      brand = androidInfo.brand;
      isNotEmu = androidInfo.isPhysicalDevice;
      model = androidInfo.model;
    }
    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      brand = "";
      isNotEmu = iosInfo.isPhysicalDevice;
      model = iosInfo.model;
    }
    sim = await SimInfo.getCarrierName;
  }
}