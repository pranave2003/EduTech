import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';

class Notificationlist extends StatefulWidget {
  const Notificationlist({super.key});

  @override
  State<Notificationlist> createState() => _NotificationlistState();
}

class _NotificationlistState extends State<Notificationlist> {
  String _selectedOption = 'Option 1';

  final notificationlist =
      FirebaseFirestore.instance.collection("notification");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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
                padding: EdgeInsets.only(left: 5, right: 5, top: 10).r,
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
                                  fontSize: 15.sp
                                ),
                              ),

                            ],
                          ),
                          Text(
                            notification[index]['content'],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp
                            ),
                          ),
                          Text(
                            notification[index]['Link'],
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(notification[index]['date'],style: TextStyle(color: Colors.grey,fontSize: 12.sp),),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(notification[index]['Time'],style: TextStyle(color: Colors.grey,fontSize: 12.sp))
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.5),
                                  blurRadius: 5.0,
                                  offset: const Offset(0.0, 5.0)),
                            ],
                            borderRadius: BorderRadius.circular(10.r),
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
    );
  }
}
