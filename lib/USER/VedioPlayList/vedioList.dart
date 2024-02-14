import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edutech/USER/VedioPlayList/VedioCatergories.dart';
import 'package:edutech/USER/VedioPlayList/test/player.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VedioListUser extends StatefulWidget {
  const VedioListUser({
    super.key,
    this.course,

    //  required String this.id
  });
  // final id;
  final course;

  @override
  State<VedioListUser> createState() => _VedioListUserState();
}

class _VedioListUserState extends State<VedioListUser> {
  List allResult = [];
  List resultList = [];
  var data;
  bool isLoaded = false;
  final TextEditingController searchController = TextEditingController();

  @override
  initState() {
    getClientStream();

    searchController.addListener(onSearchchanged);

    super.initState();
  }

  getClientStream() async {
    Future.delayed(
      Duration(milliseconds: 3000),
      () {
        setState(() {
          isLoaded = true;
        });
      },
    );
    data = await FirebaseFirestore.instance
        .collection('video')
        .where('trade', isEqualTo: widget.course)
        .get();

    setState(() {
      allResult = data.docs;
      print('-------${allResult[0]['url']}');
      // isLoaded = true;
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
            // scrolledUnderElevation: 10,

            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VedioCategory(),
                    ));
              },
            ),
            // title: Text('Vedio List'),
            // titleTextStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
            backgroundColor: Colors.purple,
            centerTitle: true,
            title: CupertinoSearchTextField(
              backgroundColor: Colors.white,
              controller: searchController,
            )),
        body: isLoaded
            ? resultList.isEmpty
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

                                  return Player(
                                      vedioId: resultList[index]['url'],
                                      id: allResult[index].id,
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
                                  color: Colors.grey.shade100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6.w),
                                    child: Image.network(
                                      YoutubePlayer.getThumbnail(
                                        videoId: resultList[index]['url'],
                                      ),
                                      fit: BoxFit.fill,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                            child: CupertinoActivityIndicator(
                                                // color: Colors.grey.shade500,
                                                ));
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Center(
                                                  child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.grey,
                                          ),
                                          Text('network error'),
                                        ],
                                      )),
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
                  )
            : GetShimmerLoading());
  }

  Shimmer GetShimmerLoading() {
    return Shimmer.fromColors(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: resultList.length,
            separatorBuilder: (context, index) => SizedBox(
              height: 20.h,
            ),
            itemBuilder: (context, index) => Row(
              children: [
                CustomCuntainer(height: 100.h, width: 150.w),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCuntainer(height: 15.h, width: 100),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomCuntainer(height: 15.h, width: 200),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomCuntainer(height: 15.h, width: 100),
                  ],
                )
              ],
            ),
          ),
        ),
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade100);
  }

  Container CustomCuntainer({
    double? width,
    double? height,
  }) =>
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r), color: Colors.yellow),
      );
}
