import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Edit video.dart';
import 'Youtube video adding.dart';

class VideoHome extends StatefulWidget {
  VideoHome({super.key});

  @override
  State<VideoHome> createState() => _VideoHomeState();
}

class _VideoHomeState extends State<VideoHome> {
  var totalvideos;
  var totalfyear;
  var totalsyear;
  var totalsub;

  @override
  void initState() {
    getTotalNumberOfDocuments();
    getCountOfFirstYearDocuments();
    getCountOfsecondYearDocuments();
    getTotalNumberOfSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfff5f6f9),
      body: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: double.infinity,
              height: size.height / 5,
              color: Colors.white,
            ),
            Expanded(
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(top: 100.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      const AppText(
                          text: "All Videos",
                          weight: FontWeight.bold,
                          size: 7,
                          textcolor: Colors.black),
                      const Divider(
                        thickness: 2,
                        color: Colors.purple,
                      ),
                      Expanded(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('video')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Text('Error${snapshot.error}');
                              }
                              final user = snapshot.data?.docs ?? [];

                              return SizedBox(
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    headingRowColor: MaterialStatePropertyAll(
                                        Colors.purple.shade200),
                                    columns: [
                                      const DataColumn(
                                          label: Text(
                                        'No',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      const DataColumn(
                                          label: Text('Subject',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))),
                                      const DataColumn(
                                          label: Text('Trade',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))),
                                      const DataColumn(
                                          label: Text('Year',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))),
                                      const DataColumn(
                                          label: Text('Actions',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))),
                                    ],
                                    rows: List<DataRow>.generate(
                                      user.length,
                                      (index) => DataRow(cells: [
                                        DataCell(Text("${index + 1}")),
                                        DataCell(Text(user[index]['subject'])),
                                        DataCell(Text(user[index]['trade'])),
                                        DataCell(Text(user[index]['year'])),
                                        DataCell(
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditVideo(
                                                        id: user[index].id,
                                                        trade: user[index]
                                                            ['trade'],
                                                        subject: user[index]
                                                            ['subject'],
                                                        url: user[index]['url'],
                                                        year: user[index]['year'],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.edit_document,
                                                  color: Colors.purple,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  showDialog<void>(
                                                    context: context,
                                                    barrierDismissible: false, // user must tap button!
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text('Are you sure Delete??'),
                                                        content: const SingleChildScrollView(
                                                          child: ListBody(
                                                            children: <Widget>[

                                                              Text('Are you shure to delete this video!!'),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: const Text('Delete'),
                                                            onPressed: () {
                                                              setState(() {
                                                                user[index]
                                                                    .reference
                                                                    .delete();
                                                              });
                                                              Fluttertoast.showToast(
                                                                  msg: "Deleted Successfully",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  //  gravity: ToastGravity.CENTER,
                                                                  timeInSecForIosWeb: 3,
                                                                  backgroundColor: Colors.red,
                                                                  textColor: Colors.white,
                                                                  fontSize: 16.0
                                                              );
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text('Cancel'),
                                                           onPressed: (){
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );

                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.purple,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
          Positioned(
            top: 100.r,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  VideoBox(
                      click: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddVideo(),
                            ));
                      },
                      name: "Add Video",
                      img:
                          "https://cdn-icons-png.flaticon.com/128/3722/3722525.png",
                      count: "_"),
                  SizedBox(
                    width: 10.w,
                  ),
                  VideoBox(
                      click: () {},
                      name: "Total Video",
                      img:
                          "https://cdn-icons-png.flaticon.com/128/11733/11733730.png",
                      count: totalvideos.toString()),
                  SizedBox(
                    width: 10.w,
                  ),
                  VideoBox(
                      click: () {},
                      name: "Total Subjects",
                      img:
                          "https://cdn-icons-png.flaticon.com/128/4465/4465416.png",
                      count: totalsub.toString()),
                  SizedBox(
                    width: 10.w,
                  ),
                  VideoBox(
                      click: () {},
                      name: "1st Year Video",
                      img:
                          "https://cdn-icons-png.flaticon.com/128/2456/2456193.png",
                      count: totalfyear.toString()),
                  SizedBox(
                    width: 10.w,
                  ),
                  VideoBox(
                      click: () {},
                      name: "2nd Year Video",
                      img:
                          "https://cdn-icons-png.flaticon.com/128/11733/11733730.png",
                      count: totalsyear.toString()),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  getTotalNumberOfDocuments() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('video').get();
    setState(() {
      totalvideos = querySnapshot.size;
    });
  }

  getCountOfFirstYearDocuments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('video')
        .where('year', isEqualTo: '1st Year')
        .get();
    setState(() {
      totalfyear = querySnapshot.size;
    });
  }

  getCountOfsecondYearDocuments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('video')
        .where('year', isEqualTo: '2nd year')
        .get();
    setState(() {
      totalsyear = querySnapshot.size;
    });
  }

  getTotalNumberOfSubjects() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('SubjectCollection').get();
    setState(() {
      totalsub = querySnapshot.size;
    });
  }
}

class VideoBox extends StatelessWidget {
  const VideoBox({
    super.key,
    required this.name,
    required this.img,
    required this.count,
    required this.click,
  });

  final String? name;
  final String? img;
  final String? count;
  final void Function() click;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
        height: 150.h,
        width: 50.w,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5.0,
              offset: const Offset(0.0, 3.0)),
        ], borderRadius: BorderRadius.circular(15).r, color: Colors.white),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AppText(
              text: name.toString(),
              weight: FontWeight.w500,
              size: 4,
              textcolor: Colors.black),
          Image.network(
            img.toString(),
            width: 13.w,
          ),
          AppText(
              text: count.toString(),
              weight: FontWeight.w600,
              size: 5,
              textcolor: Colors.black),
        ]),
      ),
    );
  }
}

class AppText extends StatelessWidget {
  const AppText(
      //Custom Text Widget.....
      {super.key,
      required this.text,
      required this.weight,
      required this.size,
      required this.textcolor});

  final String text;
  final FontWeight weight;
  final double size;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: size.sp, color: textcolor, fontWeight: weight),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
