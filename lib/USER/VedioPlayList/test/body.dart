
import 'package:edutech/USER/VedioPlayList/test/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.vedioId,
    required this.remains,
    required this.id,
  });
  final vedioId;
  final remains;
  final id;

  @override
  _hhState createState() => _hhState();
}

class _hhState extends State<Body> {
  List upnext = [];
  bool fullScreen = false;
  late YoutubePlayerController controller;
  @override
  void initState() {
    upnext = widget.remains;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(child: _buildBurnerWidgetContent()),
        SizedBox(
          height: 10.h,
        ),
        fullScreen == false
            ? Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Text('Play List',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                ],
              )
            : SizedBox(),
        fullScreen == false
            ? Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  itemCount: upnext.length,
                  itemBuilder: (context, index) {
                    // var vedioid=upnext.
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Player(
                              vedioId: upnext[index]['url'],
                              id: upnext[index].id,
                              remains: widget.remains,
                            );
                          },
                        ));
                      },
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
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
                                upnext[index].id == widget.id
                                    ? Positioned(
                                        bottom: 0,
                                        right: -10,
                                        child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: LottieBuilder.asset(
                                              'assets/loading.json',
                                              fit: BoxFit.fill,
                                            )),
                                      )
                                    : SizedBox()
                              ],
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
            : SizedBox(),
      ],
    ));
  }

  YoutubePlayerBuilder _buildBurnerWidgetContent() {
    return YoutubePlayerBuilder(
        onEnterFullScreen: () {
          fullScreen = true;
        },
        onExitFullScreen: () {
          fullScreen = false;
        },
        player: YoutubePlayer(
          aspectRatio: 16 / 9,
          controller: controller,
          showVideoProgressIndicator: true,
          onReady: () {},
          progressColors: ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.white,
          ),
        ),
        builder: (context, player) {
          return Column(
            children: [Expanded(child: player)],
          );
        });
  }
}
