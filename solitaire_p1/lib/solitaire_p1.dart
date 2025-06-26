
import 'solitaire_p1_platform_interface.dart';

class SolitaireP1 {

  static final SolitaireP1 _p1=SolitaireP1();
  static SolitaireP1 get instance => _p1;

  Future<void> openC91() async{
    SolitaireP1Platform.instance.openC91();
  }
}
