import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../Admin notification/Admin student progres.dart';
import '../Admin notification/View user login.dart';
import 'Total video.dart';

class AdminHome extends StatelessWidget {
  AdminHome({super.key});

  double profile_count = 0.9;

  String _selectedOption = 'Option 1';

  final notificationlist =
  FirebaseFirestore.instance.collection("notification");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6f9),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  text: "Welcome Admin",
                  weight: FontWeight.w500,
                  size: 2.sp,
                  textcolor: Colors.purple),
              AppText(
                  text: "Make a better world  Admin",
                  weight: FontWeight.w400,
                  size: 1.sp,
                  textcolor: Colors.grey),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Viewuserlogin(),));
                  },
                    child: Box(
                      img:
                      "https://cdn-icons-png.flaticon.com/128/3402/3402259.png",
                      title: "Students",
                      value: "15.k",
                      theam: Colors.purple.shade50,
                      iccolor: Colors.purple,
                    ),
                  ),
                  InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Total_videos();
                    },));
                  },
                    child: Box(
                      img:
                      "https://cdn-icons-png.flaticon.com/128/13447/13447074.png",
                      title: "Videos",
                      value: "100",
                      theam: Colors.blue.shade50,
                      iccolor: Colors.blue,
                    ),
                  ),
                  Box(
                    img:
                    "https://cdn-icons-png.flaticon.com/128/2128/2128421.png",
                    title: "Premium",
                    value: "10.k",
                    theam: Colors.amber.shade50,
                    iccolor: Colors.amber,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          //width: 500,
                          height: 145,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5.0,
                                  offset: const Offset(0.0, 3.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15).r,
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  AppText(
                                      text: "Payments",
                                      weight: FontWeight.w400,
                                      size: 5,
                                      textcolor: Colors.black87),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.network(
                                    "https://cdn-icons-png.flaticon.com/128/8984/8984290.png",
                                    width: 80,
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          //width: 500,
                          height: 145,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5.0,
                                  offset: const Offset(0.0, 3.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15).r,
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  AppText(
                                      text: "Payments",
                                      weight: FontWeight.w400,
                                      size: 5,
                                      textcolor: Colors.black87),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.network(
                                    "https://cdn-icons-png.flaticon.com/128/8984/8984290.png",
                                    width: 80,
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5.0,
                                  offset: const Offset(0.0, 3.0)),
                            ],
                            borderRadius: BorderRadius.circular(15).r,
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 150,
                            backgroundColor: Colors.grey.shade300,
                            lineWidth: 60,
                            //arcBackgroundColor:  Color(0xff50D8D7),
                            // fillColor: Color(0xff50D8D7),
                            progressColor: Colors.greenAccent,
                            animation: true,
                            animationDuration: 2000,
                            percent: profile_count,
                            center: Text(
                              "${profile_count * 100}%",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 320,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5.0,
                                offset: const Offset(0.0, 3.0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15).r,
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Container(
                              height: 50,
                              color: Colors.blue.shade100,
                              child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      AppText(
                                          text: "Notification",
                                          weight: FontWeight.w500,
                                          size: 5,
                                          textcolor: Colors.black87),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.notification_add_outlined,
                                            color: Colors.yellow.shade900,
                                          ),
                                          SizedBox(width: 10,),
                                          InkWell(
                                              onTap: (){},
                                              child: AppText(text: "Add", weight: FontWeight.bold, size: 5, textcolor: Colors.black87))
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            Expanded(
                              child:StreamBuilder(
                                stream: notificationlist.snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text("Error:${snapshot.error}"),
                                    );
                                  }
                                  final notification = snapshot.data?.docs ?? [];

                                  return ListView.builder(
                                    itemCount: notification.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(left: 5, right: 5, top: 0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        notification[index]['matter'],
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                  Text(
                                                    notification[index]['content'],
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                  Text(
                                                    notification[index]['Link'],
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12,
                                                        color: Colors.blue),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(notification[index]['date'],style: TextStyle(color: Colors.grey,fontSize: 12),),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(notification[index]['Time'],style: TextStyle(color: Colors.grey,fontSize: 12))
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Container(
                                                height: 2,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.blue.withOpacity(0.5),
                                                          blurRadius: 5.0,
                                                          offset: const Offset(0.0, 5.0)),
                                                    ],
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    super.key,
    required this.title,
    required this.value,
    required this.img,
    required this.theam,
    required this.iccolor,
  });

  final String title;
  final String value;
  final String img;
  final Color theam;
  final Color iccolor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200.h,
          width: 100.w,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5.0,
                offset: const Offset(0.0, 3.0)),
          ], borderRadius: BorderRadius.circular(10), color: theam),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                        text: title,
                        weight: FontWeight.w500,
                        size: 1.5.sp,
                        textcolor: Colors.grey),
                    AppText(
                        text: value,
                        weight: FontWeight.w700,
                        size: 2.sp,
                        textcolor: Colors.black87),
                  ],
                ),
                Image.network(
                  img,
                  width: 20.w,
                ),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.bookmark_border_outlined,
              size: 30,
              color: iccolor,
            ))
      ],
    );
  }
}
