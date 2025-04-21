import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'solitaire_p3_platform_interface.dart';

/// An implementation of [SolitaireP3Platform] that uses method channels.
class MethodChannelSolitaireP3 extends SolitaireP3Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('solitaire_p3');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
