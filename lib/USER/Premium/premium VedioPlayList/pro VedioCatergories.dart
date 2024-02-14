import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edutech/USER/Premium/premium%20VedioPlayList/pro%20vedioList.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class proVedioCategory extends StatefulWidget {
  proVedioCategory({super.key});

  @override
  State<proVedioCategory> createState() => _proVedioCategoryState();
}

class _proVedioCategoryState extends State<proVedioCategory> {
  Set<String> recenWatchedId = Set<String>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('premium video')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // var data = snapshot.data?.docs ?? [];
              if (ConnectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
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
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.blue,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Departments',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
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
                                        builder: (context) => proVedioListUser(
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
                                      border: Border.all(
                                          color: Colors.blue.shade100)),
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
                      ]),
                );
              }
            }),
      ),
    );
  }
}
