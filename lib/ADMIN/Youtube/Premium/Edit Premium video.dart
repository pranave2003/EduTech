import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Admin notification/Admin student progres.dart';



class Edit_PremiumVideo extends StatefulWidget {
  final url;
  final id;
  final trade;
  final year;
  final subject;
  const Edit_PremiumVideo(
      {super.key,
        required this.id,
        required this.url,
        required this.trade,
        required this.year,
        required this.subject});

  @override
  State<Edit_PremiumVideo> createState() => _Edit_PremiumVideoState();
}

Future<bool> checkYTradeExists(String link) async {
  CollectionReference videoCollection =
  FirebaseFirestore.instance.collection('TradeCollection');

  QuerySnapshot querySnapshot =
  await videoCollection.where('trade', isEqualTo: link).get();
  return querySnapshot.docs.isNotEmpty;
}
Future<bool> checkYSubjectExists(String link) async {
  CollectionReference videoCollection =
  FirebaseFirestore.instance.collection('SubjectCollection');

  QuerySnapshot querySnapshot =
  await videoCollection.where('subject', isEqualTo: link).get();
  return querySnapshot.docs.isNotEmpty;
}
late TextEditingController linkController;
late String selectedTrade;
late String selectedYear;
late String selectedSubject;
// final linkController = TextEditingController();
final addTradeControllor = TextEditingController();
// final yearcontollor = TextEditingController();
final addSubControllor = TextEditingController();
List<String> year = <String>['1st Year', '2nd year'];

class _Edit_PremiumVideoState extends State<Edit_PremiumVideo> {
  @override
  void initState() {
    super.initState();
    linkController = TextEditingController(text: widget.url);
    selectedTrade = widget.trade;
    selectedYear = widget.year;
    selectedSubject = widget.subject;
  }

  @override
  void dispose() {
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // linkController.text = widget.url;
    // var selectedTrade = widget.trade;
    // var selectedYear = widget.year;
    // var selectedSubject = widget.subject;
    return Scaffold(
      backgroundColor: const Color(0xfff5f6f9),
      appBar: AppBar(
        backgroundColor: Colors.amber,
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
                            text: "Edit Video",
                            weight: FontWeight.bold,
                            size: 7,
                            textcolor: Colors.amber),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.amber)),
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
                                                ),
                                          )
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
                                        backgroundColor: Colors.yellow,
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
                                                  bool linkExists =
                                                  await checkYTradeExists(addTradeControllor.text);

                                                  if (addTradeControllor.text.isEmpty) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text("Enter trade",style: TextStyle(color:Colors.black,)),
                                                        backgroundColor: Colors.yellow,
                                                        behavior: SnackBarBehavior.floating,
                                                      ),
                                                    );
                                                  }else if (linkExists) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text('Error'),
                                                          content: const Text(
                                                              'The provided trade already exists in the list.'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: const Text('OK',style: TextStyle(color:Colors.black,),)
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }else{await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'TradeCollection')
                                                      .add({
                                                    'trade': addTradeControllor
                                                        .text
                                                        .trim()
                                                  });
                                                  addTradeControllor.clear();}
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
                                backgroundColor: Colors.yellow,
                                child: const Text(
                                  "+",
                                  style: TextStyle(color: Colors.black),
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
                                                ),
                                          )
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
                                                  bool linkExists =
                                                  await checkYSubjectExists(addSubControllor.text);

                                                  if (addSubControllor.text.isEmpty) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text("Enter Subject",style: TextStyle(color:Colors.black,)),
                                                        backgroundColor: Colors.yellow,
                                                        behavior: SnackBarBehavior.floating,
                                                      ),
                                                    );
                                                  }else if (linkExists) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text('Error'),
                                                          content: const Text(
                                                              'The provided Subject already exists in the list.'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: const Text('OK',style: TextStyle(color:Colors.black,),)
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                  else
                                                  {await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'SubjectCollection')
                                                      .add({
                                                    'subject': addSubControllor
                                                        .text
                                                        .trim()
                                                  });
                                                  addSubControllor.clear();}
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
                                backgroundColor: Colors.yellow,
                                child: const Text(
                                  "+",
                                  style: TextStyle(color: Colors.black),
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
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible:
                                false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Are you shure?'),
                                    content: const SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text('Are You shure to add Video!!'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () async {
                                            if (linkController.text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                Text("Enter video link"),
                                                backgroundColor: Colors.purple,
                                                behavior:
                                                SnackBarBehavior.floating,
                                              ));
                                            } else if (selectedTrade == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text("Select Trade"),
                                                backgroundColor: Colors.purple,
                                                behavior:
                                                SnackBarBehavior.floating,
                                              ));
                                            } else if (selectedSubject ==null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text("Select Subject"),
                                                backgroundColor: Colors.purple,
                                                behavior:
                                                SnackBarBehavior.floating,
                                              ));
                                            } else if (selectedYear == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text("Select Year"),
                                                backgroundColor: Colors.purple,
                                                behavior:
                                                SnackBarBehavior.floating,
                                              ));
                                            } else {
                                              await FirebaseFirestore.instance
                                                  .collection('video')
                                                  .doc(widget.id)
                                                  .update({
                                                'url': linkController.text,
                                                'trade': selectedTrade,
                                                'subject': selectedSubject,
                                                'year': selectedYear
                                              });

                                              Navigator.pop(context);
                                            }
                                            Navigator.pop(context);
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.zero,
                                                      side: BorderSide(
                                                          color:
                                                          Colors.black)))),
                                          child: const Text("Edit")),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.zero,
                                                      side: BorderSide(
                                                          color:
                                                          Colors.black)))),
                                          child: const Text("Cancel",style: TextStyle(color: Colors.black),))
                                    ],
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                        side:
                                        BorderSide(color: Colors.black)))),
                            child: const Text("Update",style: TextStyle(color: Colors.black),)),
                        SizedBox(
                          width: 10.w,
                        ),
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


