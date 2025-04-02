
import 'package:solitaire_p1/p1_hep/p1_hep.dart';

StorageData<int> p2CurrentLevel=StorageData<int>(key: P2StorageName.p2CurrentLevel, defaultValue: 1);
StorageData<int> p2Coins=StorageData<int>(key: P2StorageName.p2Coins, defaultValue: 0);


StorageData<bool> p2MusicOpen=StorageData<bool>(key: P2StorageName.p2MusicOpen, defaultValue: true);
StorageData<bool> p2SoundOpen=StorageData<bool>(key: P2StorageName.p2SoundOpen, defaultValue: true);

class P2StorageName{
  static const String p2CurrentLevel="p2CurrentLevel";
  static const String p2Coins="p2Coins";
  static const String p2MusicOpen="p2MusicOpen";
  static const String p2SoundOpen="p2SoundOpen";
}