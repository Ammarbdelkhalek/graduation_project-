import 'package:flutter/material.dart';
import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:realestateapp/modules/videoandphoneCall/appBrain.dart';

class audioCall extends StatefulWidget {
  const audioCall({Key? key}) : super(key: key);

  @override
  State<audioCall> createState() => _audioCallState();
}

class _audioCallState extends State<audioCall> {
  @override
  var channelcontroller = TextEditingController();
  late int _remoteUid = 0;
  late RtcEngine _engine;
  @override
  void initState() {
    super.initState();
    channelcontroller = TextEditingController(text: AgoraManager.channelName);
    initAgora();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white70,
            child: Center(
              child: _remoteUid == 0
                  ? Text(
                      "Calling …",
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      "Calling with $_remoteUid",
                    ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0, right: 25),
              child: Container(
                height: 50,
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        icon: const Icon(
                          Icons.call_end,
                          size: 44,
                          color: Colors.redAccent,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.create(AgoraManager.appId);
    _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined successfully");
        },
        userJoined: (int uid, int elapsed) {
          // player.stop();
          print("remote user $uid joined successfully");
          setState(() => _remoteUid = uid);
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left call");
          setState(() => _remoteUid = 0);
          Navigator.of(context).pop(true);
        },
      ),
    );
    await _engine.joinChannel(
        AgoraManager.token, AgoraManager.channelName, null, 0);
  }

  //current User View
  Widget _renderLocalPreview() {
    return RtcLocalView.SurfaceView();
  }
  //remote User View

  Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId: channelcontroller.text,
      );
    } else {
      return Text(
        "Calling …",
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      );
    }
  }
}
