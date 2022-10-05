import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static Future<String> setupRemoteConfig() async {
    final RemoteConfig remoteConfig = RemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activate();
    return remoteConfig.getString('url');
  }
}