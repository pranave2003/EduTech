import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduapp/USER/Premium/premium%20VedioPlayList/pro%20VedioPlayer.dart';
import 'package:eduapp/USER/VedioPlayList/VedioPlayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class proVedioListUser extends StatefulWidget {
  const proVedioListUser({
    super.key,
    required this.course,

    //  required String this.id
  });
  // final id;
  final course;

  @override
  State<proVedioListUser> createState() => _proVedioListUserState();
}

class _proVedioListUserState extends State<proVedioListUser> {
  List allResult = [];
  List resultList = [];
  // var searchName = '';
  final TextEditingController searchController = TextEditingController();

  @override
  initState() {
    getClientStream();

    searchController.addListener(onSearchchanged);

    super.initState();
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('premiumvideo')
        .where('trade', isEqualTo: widget.course)
        .get();

    setState(() {
      allResult = data.docs;
      print('-------${allResult[0]['url']}');
    });
    searchResultList();
  }

  onSearchchanged() async {
    await searchResultList();
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchchanged);
    searchController.dispose();
    super.dispose();
  }

  searchResultList() {
    var showResult = [];
    if (searchController.text != "") {
      for (var clientsnapshot in allResult) {
        var name = clientsnapshot['subject'].toString().toLowerCase();
        if (name.contains(searchController.text.toLowerCase())) {
          showResult.add(clientsnapshot);
        }
      }
    } else {
      showResult = List.from(allResult);
    }
    setState(() {
      resultList = showResult;
    });
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var youtubeId;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(

            // leading: BackButton(color: Colors.white),
            // title: Text('Vedio List'),
            // titleTextStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
            backgroundColor: Colors.blue.shade100,
            centerTitle: true,
            title: CupertinoSearchTextField(
              backgroundColor: Colors.white,
              controller: searchController,
            )),
        body: allResult.isEmpty
            ? LinearProgressIndicator(
                color: Colors.blue,
              )
            : resultList.isEmpty
                ? Center(
                    child: Lottie.network(
                        'https://lottie.host/08fad6f8-46ea-4771-bcfb-9fc59cb9128a/A0vHdKzMT5.json',
                        height: 200.h,
                        width: 200.w),
                  )
                : ListView.builder(
                    itemCount: resultList.length,
                    itemBuilder: (context, index) {
                      // print(resultList);

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10)
                            .w,
                        child: SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  print('---${resultList[index]['url']}');

                                  return proVedioplayerUser(
                                      vedioId: resultList[index]['url'],
                                      remains: allResult);
                                },
                              ));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6.w),
                                    child: Image.network(
                                      YoutubePlayer.getThumbnail(
                                        videoId: resultList[index]['url'],
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
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(resultList[index]['subject'],
                                        style: TextStyle(color: Colors.black)),
                                    Text('More about Courses',
                                        style: TextStyle(color: Colors.black)),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text('10k views',
                                        style: TextStyle(color: Colors.black)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ));
  }
}
