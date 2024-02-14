import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VedioplayerUser extends StatefulWidget {
  const VedioplayerUser({
    super.key,
    required this.vedioId,
    required this.remains,
  });
  final vedioId;
  final remains;

  @override
  State<VedioplayerUser> createState() => _VedioplayerUserState();
}

class _VedioplayerUserState extends State<VedioplayerUser> {
  late YoutubePlayerController controller;
  // late PlayerState _playerState;
  // late YoutubeMetaData _vedioMetaData;
  bool isplayerReady = false;
  List upnext = [];

  @override
  void initState() {
    super.initState();
    upnext = widget.remains;
    // setState(() {
    //   upnext.removeWhere(
    //     (element) => element.url == widget.vedioId,
    //   );
    // });

    controller = YoutubePlayerController(
      initialVideoId: widget.vedioId,
      flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          showLiveFullscreenButton: true,
          useHybridComposition: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          hideControls: false,
          controlsVisibleAtStart: false,
          hideThumbnail: true),
    );

    // controller.toggleFullScreenMode();
  }

  // @override
  // void deactivate() {
  // TODO: implement deactivate
  //   super.deactivate();
  //   controller.pause();
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 300.h, child: YoutubePlayerCustom()),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10).w,
              child: Row(
                children: [
                  Text('Up next',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                itemCount: upnext.length,
                itemBuilder: (context, index) {
                  // var vedioid=upnext.
                  return InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return VedioplayerUser(vedioId: youtubeLink);
                      //   },
                      // ));
                    },
                    child: SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            height: 100,
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.w),
                              child: Image.network(
                                YoutubePlayer.getThumbnail(
                                  videoId: upnext[index]['url'],
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('subject',
                                  style: TextStyle(color: Colors.black)),
                              Text('More about Courses',
                                  style: TextStyle(color: Colors.black)),
                              Text('10k views',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ]),
          Positioned(
              left: 5,
              top: 30,
              child: BackButton(
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  OrientationBuilder YoutubePlayerCustom() {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return YoutubePlayer(
            controller: controller,
          );
        } else
          return YoutubePlayer(
            bottomActions: [
              // CurrentPosition(),
              ProgressBar(isExpanded: true),
              FullScreenButton(controller: controller),
            ],
            controller: controller,
            showVideoProgressIndicator: false,
            progressIndicatorColor: Colors.blueAccent,
          );
      },
    );
  }
}
