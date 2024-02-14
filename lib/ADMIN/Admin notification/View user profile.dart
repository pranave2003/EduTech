import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class Viewuserprofile extends StatefulWidget {
  Viewuserprofile({super.key, this.id});
  final id;
  @override
  State<Viewuserprofile> createState() => _ViewuserprofileState();
}

bool isSelected = false;

class _ViewuserprofileState extends State<Viewuserprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        surfaceTintColor: Colors.purple,
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            SizedBox(
              width: 20,
            ),
            Text(
              "Profile",
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white70,

      //==========================================================================================================

      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("UserRegister")
                .doc(widget.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              return Center(
                child: Container(
                  width: 800,
                  height: 600,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.purple.withOpacity(0.5),
                            blurRadius: 5.0,
                            offset: const Offset(0.0, 5.0)),
                      ],
                      borderRadius: BorderRadius.circular(10).r,
                      color: Colors.white),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      CircleAvatar(
                        radius: 55.r,
                        child: Image.network(
                            'https://cdn0.iconfinder.com/data/icons/kameleon-free-pack-rounded/110/Student-3-1024.png'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          snapshot.data!['Name'],
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),

                      //==============================================================================================================

                      Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100).r,
                        child: Column(
                          children: [
                            Table(
                              border: TableBorder.all(color: Colors.white),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(children: [
                                  Container(
                                    height: 40,
                                    child: TableCell(
                                      child: Text(
                                        "Student Name",
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                      child: Center(child: Text(":")),
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle),
                                  TableCell(
                                    child: Text(
                                      snapshot.data!['Name'],
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ]),

                                //===========================================================================================================================

                                TableRow(children: [
                                  Container(
                                    height: 40,
                                    child: TableCell(
                                      child: Text(
                                        "E-mail",
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                      child: Center(child: Text(":")),
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle),
                                  TableCell(
                                    child: Text(
                                      snapshot.data!['Email'],
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ]),

                                //===========================================================================================================================
                                TableRow(children: [
                                  Container(
                                    height: 40,
                                    child: TableCell(
                                      child: Text(
                                        "Phone Number",
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                      child: Center(child: Text(":")),
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle),
                                  TableCell(
                                    child: Text(
                                      snapshot.data!['Phone number'],
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ]),

                                //===========================================================================================================================
                                TableRow(children: [
                                  Container(
                                    height: 40,
                                    child: TableCell(
                                      child: Text(
                                        "College",
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                      child: Center(child: Text(":")),
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle),
                                  TableCell(
                                    child: Text(
                                      snapshot.data!['College'],
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ]),

                                //===========================================================================================================================
                                TableRow(children: [
                                  Container(
                                    height: 40,
                                    child: TableCell(
                                      child: Text(
                                        "Department",
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                      child: Center(child: Text(":")),
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle),
                                  TableCell(
                                    child: Text(
                                      snapshot.data!['Department'],
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ]),

                                //===========================================================================================================================
                                TableRow(children: [
                                  Container(
                                    height: 40,
                                    child: TableCell(
                                      child: Text(
                                        "Year",
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                      child: Center(child: Text(":")),
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle),
                                  TableCell(
                                    child: Text(
                                      snapshot.data!['Year'],
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ]),

                                //===========================================================================================================================
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add premium member",
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CupertinoSwitch(
                            trackColor: Colors.purple,

                            activeColor: Colors.yellow,
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                isSelected = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 100.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 5.0,
                                        offset: const Offset(0.0, 5.0)),
                                  ],
                                  borderRadius: BorderRadius.circular(10).r,
                                  color: Colors.purple),
                              child: Center(
                                child: Text(
                                  "Back",
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 60.h,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
