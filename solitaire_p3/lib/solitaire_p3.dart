
import 'solitaire_p3_platform_interface.dart';

class SolitaireP3 {
  Future<String?> getPlatformVersion() {
    return SolitaireP3Platform.instance.getPlatformVersion();
  }
}
