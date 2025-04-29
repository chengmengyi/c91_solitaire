
import 'package:solitaire_p1/p1_hep/p1_hep.dart';

StorageData<int> p3CurrentLevel=StorageData<int>(key: P3StorageName.p3CurrentLevel, defaultValue: 1);
StorageData<int> p3TopPro=StorageData<int>(key: P3StorageName.p3TopPro, defaultValue: 0);
StorageData<int> p3PlayCardNum=StorageData<int>(key: P3StorageName.p3PlayCardNum, defaultValue: 0);
StorageData<int> p3LastMoneyLevel=StorageData<int>(key: P3StorageName.p3LastMoneyLevel, defaultValue: 0);


StorageData<double> p3Coins=StorageData<double>(key: P3StorageName.p3Coins, defaultValue: 0.0);

StorageData<bool> p3LastIsLuckyCard=StorageData<bool>(key: P3StorageName.p3LastIsLuckyCard, defaultValue: false);
StorageData<bool> p3NewUserGuideCompleted=StorageData<bool>(key: P3StorageName.p3NewUserGuideCompleted, defaultValue: false);
StorageData<bool> p3ShowedLongJuanFengGuide=StorageData<bool>(key: P3StorageName.p3ShowedLongJuanFengGuide, defaultValue: false);

class P3StorageName{
  static const String p3CurrentLevel="p3CurrentLevel";
  static const String p3Coins="p3Coins";
  static const String p3MusicOpen="p3MusicOpen";
  static const String p3SoundOpen="p3SoundOpen";
  static const String p3TopPro="p3TopPro";
  static const String p3LastIsLuckyCard="p3LastIsLuckyCard";
  static const String p3NewUserGuideCompleted="p3NewUserGuideCompleted";
  static const String p3ShowedLongJuanFengGuide="p3ShowedLongJuanFengGuide";
  static const String p3PlayCardNum="p3PlayCardNum";
  static const String p3LastMoneyLevel="p3LastMoneyLevel";
}