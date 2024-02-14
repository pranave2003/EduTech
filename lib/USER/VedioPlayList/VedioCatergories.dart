import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduapp/USER/VedioPlayList/VedioPlayer.dart';
import 'package:eduapp/USER/VedioPlayList/Widgets/customCupertinoTextField.dart';
import 'package:eduapp/USER/VedioPlayList/vedioList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VedioCategory extends StatefulWidget {
  VedioCategory({super.key});

  @override
  State<VedioCategory> createState() => _VedioCategoryState();
}

class _VedioCategoryState extends State<VedioCategory> {
  Set<String> recenWatchedId = Set<String>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: CustomCupertinoTextField(
      //       placeholder: 'Search',
      //       searchController: searchController,
      //       preffix: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      //         child: Icon(
      //           Icons.search,
      //           color: const Color.fromRGBO(117, 117, 117, 1),
      //         ),
      //       )),
      // ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('video').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // var data = snapshot.data?.docs ?? [];
              if (ConnectionState == ConnectionState.waiting) {
                return LinearProgressIndicator();
              }
              var documents = snapshot.data?.docs ?? [];
              // List<DocumentSnapshot> documents = snapshot.data!.docs;
              Set<String> uniqueFieldNames = Set<String>();
              for (int i = 0; i < documents.length; i++) {
                uniqueFieldNames.add(documents[i]['trade']);
              }
              print(uniqueFieldNames.toList());

              if (uniqueFieldNames.isEmpty) {
                return LinearProgressIndicator();
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Departments',
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            // Icon(Icons.filter_list_rounded)
                            // IconButton(
                            //     onPressed: () {}, icon: Icon(Icons.filter_list_rounded))
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 5.h),
                            itemCount: uniqueFieldNames.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VedioListUser(
                                            course: uniqueFieldNames
                                                .elementAt(index)),
                                      ));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.w),
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6.r),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.85),
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0),
                                            spreadRadius: 1)
                                      ],
                                      border: Border.all(color: Colors.purple)),
                                  child: Center(
                                    child: Text(
                                      uniqueFieldNames
                                          .elementAt(index)
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Spacer(),
                        Text(
                          'Recently Viewed',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height / 5,
                          child: recenWatchedId.isEmpty
                              ? Center(child: Text('No recent watched vedios'))
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           VedioplayerUser(
                                            //               vedioId: vedioId),
                                            //     ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            decoration: BoxDecoration(
                                              color: Colors.deepPurpleAccent,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 2,
                                                    spreadRadius: 1,
                                                    color: Color.fromARGB(
                                                        255, 153, 123, 205))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.w),
                                            ),
                                            height: 150,
                                            width: 200,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.w),
                                              child: Image.network(
                                                YoutubePlayer.getThumbnail(
                                                  videoId: recenWatchedId
                                                      .elementAt(index),
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 20,
                                          // )
                                        )
                                      ],
                                    );
                                  },
                                ),
                        )
                      ]),
                );
              }
            }),
      ),
    );
  }
}
