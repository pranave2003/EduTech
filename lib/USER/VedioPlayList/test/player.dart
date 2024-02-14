import 'package:edutech/USER/VedioPlayList/test/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Player extends StatefulWidget {
  const Player({
    super.key,
    required this.vedioId,
    required this.remains,
    required this.id,
  });
  final vedioId;
  final remains;
  final id;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  // List upnext = [];
  // @override
  // void initState() {
  //   upnext = widget.remains;
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientaion) {
        switch (orientaion) {
          case Orientation.portrait:
            return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: Colors.purple,
                  // title: Text(widget.video.title),
                  title: Text(
                    "Detail",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                body: Body(
                  vedioId: widget.vedioId,
                  id: widget.id,
                  remains: widget.remains,
                ));

          // TODO: Handle this case.
          // break;
          case Orientation.landscape:
            return Scaffold(
                resizeToAvoidBottomInset: true,
                body: Body(
                    vedioId: widget.vedioId,
                    id: widget.id,
                    remains: widget.remains));

          // TODO: Handle this case.
        }
      }),
    );
  }
}
