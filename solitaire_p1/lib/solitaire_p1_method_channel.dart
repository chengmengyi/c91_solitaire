import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'solitaire_p1_platform_interface.dart';

/// An implementation of [SolitaireP1Platform] that uses method channels.
class MethodChannelSolitaireP1 extends SolitaireP1Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('solitaire_p1');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
