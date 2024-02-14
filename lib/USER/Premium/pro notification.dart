import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';

class ProNotification extends StatefulWidget {
  const ProNotification({super.key});

  @override
  State<ProNotification> createState() => _ProNotificationState();
}

class _ProNotificationState extends State<ProNotification> {
  final notificationlist = FirebaseFirestore.instance
      .collection("notification")
      .where("premium", isEqualTo: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Text(
            "Notifications",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: Colors.white),
          )),
      body: StreamBuilder(
        stream: notificationlist.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.purple),
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
                padding: EdgeInsets.all(10.sp),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.blue.withOpacity(0.5), // color of shadow
                          spreadRadius: 2, // spread radius
                          blurRadius: 2, // blur radius
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(notification[index]['matter'],
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/adminlogo.png"),
                          backgroundColor: Colors.white,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: 350.w,
                              child: Text(notification[index]['content'])),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: 350.w,
                              child: Column(
                                children: [
                                  Link(
                                    uri: Uri.parse(notification[index]['Link']),
                                    builder: (context, followLink) =>
                                        TextButton(
                                            onPressed: followLink,
                                            child: Text(
                                              (notification[index]["Link"]),
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            )),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(notification[index]['date']),
                          SizedBox(
                            width: 10,
                          ),
                          Text(notification[index]['Time'])
                        ],
                      ),
                    )
                  ]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
