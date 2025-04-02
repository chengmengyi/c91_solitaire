
import 'solitaire_p1_platform_interface.dart';

class SolitaireP1 {
  Future<String?> getPlatformVersion() {
    return SolitaireP1Platform.instance.getPlatformVersion();
  }
}
