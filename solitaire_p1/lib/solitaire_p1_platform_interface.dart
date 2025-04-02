import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'solitaire_p1_method_channel.dart';

abstract class SolitaireP1Platform extends PlatformInterface {
  /// Constructs a SolitaireP1Platform.
  SolitaireP1Platform() : super(token: _token);

  static final Object _token = Object();

  static SolitaireP1Platform _instance = MethodChannelSolitaireP1();

  /// The default instance of [SolitaireP1Platform] to use.
  ///
  /// Defaults to [MethodChannelSolitaireP1].
  static SolitaireP1Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SolitaireP1Platform] when
  /// they register themselves.
  static set instance(SolitaireP1Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
