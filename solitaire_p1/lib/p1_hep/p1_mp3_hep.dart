import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';

StorageData<bool> p2MusicOpen=StorageData<bool>(key: "MusicOpen", defaultValue: true);
StorageData<bool> p2SoundOpen=StorageData<bool>(key: "SoundOpen", defaultValue: true);



class P1Mp3Hep{
  factory P1Mp3Hep()=>_getInstance();
  static P1Mp3Hep get instance => _getInstance ();
  static P1Mp3Hep? _instance;
  static P1Mp3Hep _getInstance(){
    _instance??=P1Mp3Hep._internal();
    return _instance!;
  }

  final _bgAudioPlayer=AudioPlayer();
  final _voiceAudioPlayer=AudioPlayer();

  P1Mp3Hep._internal(){
    _voiceAudioPlayer.onPlayerStateChanged.listen((event) {
      if(p2MusicOpen.getData()){
        if(event==PlayerState.playing){
          _bgAudioPlayer.pause();
        }else if(event==PlayerState.completed){
          _bgAudioPlayer.resume();
        }
      }
    });
  }

  playBgMp3(){
    if(p2MusicOpen.getData()){
      _bgAudioPlayer.setReleaseMode(ReleaseMode.loop);
      _bgAudioPlayer.play(AssetSource("bg.MP3"));
    }
  }

  setPlayOrStopBg(){
    if(p2MusicOpen.getData()){
      p2MusicOpen.saveData(false);
      _bgAudioPlayer.stop();
    }else{
      p2MusicOpen.saveData(true);
      playBgMp3();
    }
  }

  setPlaySound(){
    p2SoundOpen.saveData(!p2SoundOpen.getData());
  }

  playXiaoChu(){
    if(p2SoundOpen.getData()){
      _voiceAudioPlayer.play(AssetSource("xiaochu.MP3"));
    }
  }

  playShengLi(){
    if(p2SoundOpen.getData()){
      _voiceAudioPlayer.play(AssetSource("shengli.MP3"));
    }
  }

  playShiBai(){
    if(p2SoundOpen.getData()){
      _voiceAudioPlayer.play(AssetSource("shibai.MP3"));
    }
  }

  playFeng(){
    if(p2SoundOpen.getData()){
      _voiceAudioPlayer.play(AssetSource("feng.MP3"));
    }
  }

  test(){
    if(p2SoundOpen.getData()){
      _voiceAudioPlayer.play(AssetSource("shibai.MP3"));
    }
  }
}