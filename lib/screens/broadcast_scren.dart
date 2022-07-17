import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import 'package:http/http.dart' as http;
import 'package:streamer/screens/home_page.dart';
import 'package:streamer/screens/web_homepage/web_homepage.dart';

import '../app_id.dart';
import '../recources/user_provider.dart';
import '../resources/firebase_methods.dart';
import '../responsive/responsive_layout.dart';
import '../widgets/chat.dart';
import '../widgets/custom_button.dart';

class BroadcastScreen extends StatefulWidget {
  final bool isBroadcaster;
  final String channelId;
  const BroadcastScreen({
    Key? key,
    required this.isBroadcaster,
    required this.channelId,
  }) : super(key: key);

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  late final RtcEngine _engine;
  List<int> remoteUid = [];
  bool switchCamera = true;
  bool isMuted = false;
  bool isScreenSharing = false;

  @override
  void initState() {
    super.initState();
    _initEngine();
  }

  void _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    print("testing setstate");
    _addListeners();
    print("Okkkkkkkkk");
    await _engine.enableVideo();
    print("hmmmmm1");
    await _engine.startPreview();
    print("hmmmmm2");
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      print("hmmmmm");
      _engine.setClientRole(ClientRole.Audience);
    }
    _joinChannel();
  }

  String baseUrl = "https://streamer-server1.herokuapp.com";

  String? token;

  Future<void> getToken() async {
    final res = await http.get(
      Uri.parse(baseUrl +
          '/rtc/' +
          widget.channelId +
          '/publisher/userAccount/' +
          Provider.of<UserProvider>(context, listen: false).user.uid +
          '/'),
    );

    if (res.statusCode == 200) {
      setState(() {
        token = res.body;
        token = jsonDecode(token!)['rtcToken'];
      });
    } else {
      debugPrint('Failed to fetch the token');
    }
  }

  void _addListeners() {
    _engine.setEventHandler(
        RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
      debugPrint('joinChannelSuccess $channel $uid $elapsed');
    }, userJoined: (uid, elapsed) {
      debugPrint('userJoined $uid $elapsed');
      setState(() {
        remoteUid.add(uid);
        print("gcltxuxjcc");
        print(uid);
      });
    }, userOffline: (uid, reason) {
      debugPrint('userOffline $uid $reason');
      setState(() {
        remoteUid.removeWhere((element) => element == uid);
      });
    }, leaveChannel: (stats) {
      debugPrint('leaveChannel $stats');
      setState(() {
        remoteUid.clear();
      });
    }, tokenPrivilegeWillExpire: (token) async {
      await getToken();
      await _engine.renewToken(token);
    }));
  }

  void _joinChannel() async {
    await getToken();
    if (token != null) {
      widget.isBroadcaster
          ? defaultTargetPlatform == TargetPlatform.android
              ? await [Permission.microphone, Permission.camera].request()
              : await _engine.joinChannelWithUserAccount(
                  token,
                  widget.channelId,
                  Provider.of<UserProvider>(context, listen: false).user.uid,
                )
          : await _engine.joinChannelWithUserAccount(
              token,
              widget.channelId,
              Provider.of<UserProvider>(context, listen: false).user.uid,
            );
    }
  }

  void _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      debugPrint('switchCamera $err');
    });
  }

  void onToggleMute() async {
    setState(() {
      isMuted = !isMuted;
    });
    await _engine.muteLocalAudioStream(isMuted);
  }

  _startScreenShare() async {
    final helper = await _engine.getScreenShareHelper(
        appGroup: kIsWeb || Platform.isWindows ? null : 'io.agora');
    await helper.disableAudio();
    await helper.enableVideo();
    await helper.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await helper.setClientRole(ClientRole.Broadcaster);
    var windowId = 0;
    var random = Random();
    if (!kIsWeb &&
        (Platform.isWindows || Platform.isMacOS || Platform.isAndroid)) {
      final windows = _engine.enumerateWindows();
      if (windows.isNotEmpty) {
        final index = random.nextInt(windows.length - 1);
        debugPrint('Screensharing window with index $index');
        windowId = windows[index].id;
      }
    }
    await helper.startScreenCaptureByWindowId(windowId);
    setState(() {
      isScreenSharing = true;
    });
    await helper.joinChannelWithUserAccount(
      token,
      widget.channelId,
      Provider.of<UserProvider>(context, listen: false).user.uid,
    );
  }

  _stopScreenShare() async {
    final helper = await _engine.getScreenShareHelper();
    await helper.destroy().then((value) {
      setState(() {
        isScreenSharing = false;
      });
    }).catchError((err) {
      debugPrint('StopScreenShare $err');
    });
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    if ('${Provider.of<UserProvider>(context, listen: false).user.uid}${Provider.of<UserProvider>(context, listen: false).user.name}' ==
        widget.channelId) {
      await FirestoreMethods().endLiveStream(widget.channelId);
    } else {
      await FirestoreMethods().updateViewCount(widget.channelId, false);
    }
    Navigator.pushReplacementNamed(context, WebhomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return WillPopScope(
        onWillPop: () async {
          await _leaveChannel();
          return Future.value(true);
        },
        child: Scaffold(
          bottomNavigationBar: widget.isBroadcaster
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: CustomButton(
                    text: 'End Stream',
                    onTap: _leaveChannel,
                  ),
                )
              : null,
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: ResponsiveLatout(
              desktopBody: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _renderVideo(user, isScreenSharing),
                        if ("${user.uid}${user.name}" == widget.channelId)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: _switchCamera,
                                child: const Text(
                                  'Switch Camera',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              InkWell(
                                onTap: onToggleMute,
                                child: Text(
                                  isMuted ? 'Unmute' : 'Mute',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              InkWell(
                                onTap: isScreenSharing
                                    ? _stopScreenShare
                                    : _startScreenShare,
                                child: Text(
                                  isScreenSharing
                                      ? 'Stop ScreenSharing'
                                      : 'Start Screensharing',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Expanded(child: Chat(channelId: widget.channelId)),
                ],
              ),
              mobileBody: Column(
                children: [
                  _renderVideo(user, isScreenSharing),
                  if ("${user.uid}${user.name}" == widget.channelId)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: _switchCamera,
                          child: const Text(
                            'Switch Camera',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        InkWell(
                          onTap: onToggleMute,
                          child: Text(
                            isMuted ? 'Unmute' : 'Mute',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  Expanded(
                    child: Chat(
                      channelId: widget.channelId,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _renderVideo(user, isScreenSharing) {
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: "${user.uid}${user.name}" == widget.channelId
          ? isScreenSharing
              ?
              // kIsWeb
              //     ?
              const RtcLocalView.SurfaceView.screenShare()
              // : const RtcLocalView.TextureView.screenShare()
              : const RtcLocalView.SurfaceView(
                  zOrderMediaOverlay: true,
                  zOrderOnTop: true,
                )
          : isScreenSharing
              // ? kIsWeb
              ? const RtcLocalView.SurfaceView.screenShare()
              // : const RtcLocalView.TextureView.screenShare()
              : remoteUid.isNotEmpty
                  // ? kIsWeb
                  ? RtcRemoteView.SurfaceView(
                      uid: remoteUid[0],
                      channelId: widget.channelId,
                    )
                  // : RtcRemoteView.TextureView(
                  //     uid: remoteUid[0],
                  //     channelId: widget.channelId,
                  //   )
                  : Container(
                      child: Text(
                        "bbhhjk",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
    );
  }
}
