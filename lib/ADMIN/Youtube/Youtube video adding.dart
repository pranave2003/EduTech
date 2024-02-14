import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'Admin panal.dart';

class AddVideo extends StatefulWidget {
  const AddVideo({super.key});

  @override
  State<AddVideo> createState() => _AddVideoState();
}

final linkController = TextEditingController();
final addTradeControllor = TextEditingController();
final yearcontollor = TextEditingController();
final addSubControllor = TextEditingController();
var vedioId;
List<String> year = <String>['1st Year', '2nd year'];

String? selectedTrade;
String? selectedYear;
String? selectedSubject;
String? selectedModule;

class _AddVideoState extends State<AddVideo> {
  Future<bool> checkLinkExists(String link) async {
    // Reference to the Firestore collection
    CollectionReference videoCollection =
    FirebaseFirestore.instance.collection('video');

    // Query to check if the document with the given link exists
    QuerySnapshot querySnapshot =
    await videoCollection.where('url', isEqualTo: link).get();

    // Check if any documents are returned
    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6f9),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(children: [
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
          child: Container(
            //height: 300.h,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5.0,
                  offset: const Offset(0.0, 3.0)),
            ], borderRadius: BorderRadius.circular(15).r, color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                            text: "Add Video",
                            weight: FontWeight.bold,
                            size: 7,
                            textcolor: Colors.purple),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.purple)),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.purple,
                                )))
                      ],
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: linkController,
                            decoration: InputDecoration(
                                label: const Text("Enter Video link"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('TradeCollection')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    List<String> tradeList = snapshot.data!.docs
                                        .map((DocumentSnapshot document) =>
                                        document['trade'].toString())
                                        .toList();

                                    return Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black54),
                                            borderRadius:
                                            BorderRadius.circular(8)),
                                        child: DropdownButton<String>(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 3),
                                          underline: const SizedBox(),
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          hint: const Text("Select Trade"),
                                          value: selectedTrade,
                                          // Set initial value if needed
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedTrade = newValue!;
                                            });
                                          },

                                          items: tradeList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              FloatingActionButton(
                                onPressed: () async {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                    false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Add Trade'),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.purple,
                                                ))
                                          ],
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              TextFormField(
                                                controller: addTradeControllor,
                                                decoration: const InputDecoration(
                                                    border:
                                                    OutlineInputBorder()),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'TradeCollection')
                                                      .add({
                                                    'trade': addTradeControllor
                                                        .text
                                                        .trim()
                                                  });
                                                  addTradeControllor.clear();
                                                },
                                                style: const ButtonStyle(
                                                    shape: MaterialStatePropertyAll(
                                                        BeveledRectangleBorder())),
                                                child: const Text("Add Trade"),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                mini: true,
                                shape: const RoundedRectangleBorder(),
                                backgroundColor: Colors.purple,
                                child: const Text(
                                  "+",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(8)),
                            child: DropdownButton<String>(
                              underline: const SizedBox(),
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              value: selectedYear,
                              hint: const Text("Select Year"),
                              //icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),

                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  selectedYear = value!;
                                });
                              },
                              items: year.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('SubjectCollection')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    List<String> tradeList = snapshot.data!.docs
                                        .map((DocumentSnapshot document) =>
                                        document['subject'].toString())
                                        .toList();

                                    return Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black54),
                                            borderRadius:
                                            BorderRadius.circular(8)),
                                        child: DropdownButton<String>(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 3),
                                          underline: const SizedBox(),
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          hint: const Text("Select Subject"),
                                          value: selectedSubject,
                                          // Set initial value if needed
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedSubject = newValue!;
                                            });
                                          },

                                          items: tradeList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              FloatingActionButton(
                                onPressed: () async {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                    false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Add Subject'),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.purple,
                                                ))
                                          ],
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              TextFormField(
                                                controller: addSubControllor,
                                                decoration: const InputDecoration(
                                                    border:
                                                    OutlineInputBorder()),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'SubjectCollection')
                                                      .add({
                                                    'subject': addSubControllor
                                                        .text
                                                        .trim()
                                                  });
                                                  addSubControllor.clear();
                                                },
                                                style: const ButtonStyle(
                                                    shape: MaterialStatePropertyAll(
                                                        BeveledRectangleBorder())),
                                                child:
                                                const Text("Add Subject"),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                mini: true,
                                shape: const RoundedRectangleBorder(),
                                backgroundColor: Colors.purple,
                                child: const Text(
                                  "+",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              vedioId = YoutubePlayer.convertUrlToId(
                                  linkController.text);
                              print('-----------${vedioId}');
                              // Check if the link already exists
                              bool linkExists =
                              await checkLinkExists(linkController.text);

                              if (linkController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Enter video link"),
                                    backgroundColor: Colors.purple,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else if (selectedTrade == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Select Trade"),
                                    backgroundColor: Colors.purple,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else if (selectedSubject == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Select Subject"),
                                    backgroundColor: Colors.purple,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else if (selectedYear == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Select Year"),
                                    backgroundColor: Colors.purple,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else if (linkExists) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'The provided link already exists in the database.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                await FirebaseFirestore.instance
                                    .collection('video')
                                    .add({
                                  'url': vedioId,
                                  'trade': selectedTrade,
                                  'subject': selectedSubject,
                                  'year': selectedYear
                                });
                                setState(() {
                                  linkController.clear();
                                  selectedTrade = null;
                                  selectedSubject = null;
                                  selectedYear = null;
                                });
                                Fluttertoast.showToast(
                                    msg: "Uploaded Successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    //  gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                        side:
                                        BorderSide(color: Colors.purple)))),
                            child: const Text("Add")),
                        SizedBox(
                          width: 10.w,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                linkController.clear();
                                selectedTrade = null;
                                selectedSubject = null;
                                selectedYear = null;
                              });
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                        side:
                                        BorderSide(color: Colors.purple)))),
                            child: const Text("Clear"))
                      ],
                    )
                  ]),
            ),
          ),
        )
      ]),
    );
  }
}