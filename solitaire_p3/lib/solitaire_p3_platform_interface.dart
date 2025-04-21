import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'solitaire_p3_method_channel.dart';

abstract class SolitaireP3Platform extends PlatformInterface {
  /// Constructs a SolitaireP3Platform.
  SolitaireP3Platform() : super(token: _token);

  static final Object _token = Object();

  static SolitaireP3Platform _instance = MethodChannelSolitaireP3();

  /// The default instance of [SolitaireP3Platform] to use.
  ///
  /// Defaults to [MethodChannelSolitaireP3].
  static SolitaireP3Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SolitaireP3Platform] when
  /// they register themselves.
  static set instance(SolitaireP3Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
