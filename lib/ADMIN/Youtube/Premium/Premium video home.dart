
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Add premium video.dart';
import 'Edit Premium video.dart';

class Premuim_VideoHome extends StatefulWidget {
  Premuim_VideoHome({super.key});

  @override
  State<Premuim_VideoHome> createState() => _Premuim_VideoHomeState();
}

class _Premuim_VideoHomeState extends State<Premuim_VideoHome> {
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
                          text: "Premium Videos",
                          weight: FontWeight.bold,
                          size: 7,
                          textcolor: Colors.black),
                      Divider(
                        thickness: 2,
                        color: Colors.grey.shade400,
                      ),
                      Expanded(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('premiumvideo')
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
                                        Colors.amber.shade200),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'No',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataColumn(
                                          label: Text('Subject',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))),
                                      DataColumn(
                                          label: Text('Trade',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))),
                                      DataColumn(
                                          label: Text('Year',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))),
                                      DataColumn(
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
                                                          Edit_PremiumVideo(
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
                                                icon: Icon(
                                                  Icons.edit_document,
                                                  color: Colors.amber,
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
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.amber,
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
                              builder: (context) => Premium_videoAdd(),
                            ));
                      },
                      name: "Add Video",
                      img:
                          "https://cdn-icons-png.flaticon.com/128/10703/10703016.png",
                      count: "_"),
                  SizedBox(
                    width: 10.w,
                  ),
                  VideoBox(
                      click: () {},
                      name: "Total Video",
                      img:
                          "https://cdn-icons-png.flaticon.com/128/3211/3211382.png",
                      count: totalvideos.toString()),
                  SizedBox(
                    width: 10.w,
                  ),
                  VideoBox(
                      click: () {},
                      name: "Total Subjects",
                      img:
                          "https://cdn-icons-png.flaticon.com/128/5832/5832416.png",
                      count: totalsub.toString()),
                  SizedBox(
                    width: 10.w,
                  ),
                  VideoBox(
                      click: () {},
                      name: "1st Year Video",
                      img:
                          "https://cdn-icons-png.flaticon.com/128/3797/3797550.png",
                      count: totalfyear.toString()),
                  SizedBox(
                    width: 10.w,
                  ),
                  VideoBox(
                      click: () {},
                      name: "2nd Year Video",
                      img:
                          "https://cdn-icons-png.flaticon.com/128/5618/5618775.png",
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
        await FirebaseFirestore.instance.collection('premiumvideo').get();
    setState(() {
      totalvideos = querySnapshot.size;
    });
  }

  getCountOfFirstYearDocuments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('premiumvideo')
        .where('year', isEqualTo: '1st Year')
        .get();
    setState(() {
      totalfyear = querySnapshot.size;
    });
  }

  getCountOfsecondYearDocuments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('premiumvideo')
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
        ], borderRadius: BorderRadius.circular(15).r, color: Colors.amber),
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
