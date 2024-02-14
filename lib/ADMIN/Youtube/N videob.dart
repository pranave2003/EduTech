import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Edit video.dart';

class Normal_video extends StatefulWidget {
  const Normal_video({super.key});

  @override
  State<Normal_video> createState() => _Normal_videoState();
}

class _Normal_videoState extends State<Normal_video> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('video')
            .where('year', isEqualTo: '1st Year')
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

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:20 ),
            child: SizedBox(
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
            ),
          );
        });
  }
}