import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.setDefaults(<String, dynamic>{'url': ""});
    await remoteConfig.fetchAndActivate();
    return remoteConfig;
  }
}