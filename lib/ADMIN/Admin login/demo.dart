//
//
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Viewuserlogin extends StatefulWidget {
//   const Viewuserlogin({super.key});
//
//   @override
//   State<Viewuserlogin> createState() => _ViewuserloginState();
// }
//
// class _ViewuserloginState extends State<Viewuserlogin> {
//   bool startAnimation = false;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(() {
//         startAnimation = true;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.purple[400],
//         surfaceTintColor: Colors.purple[400],
//         title: Row(
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             const Text(
//               "All Students",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: FutureBuilder(
//         future: FirebaseFirestore.instance.collection("UserRegister").get(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }
//           final users = snapshot.data?.docs ?? [];
//
//           return SizedBox(
//             width: double.infinity,
//             child: DataTable(
//
//               columns: [
//                 DataColumn(
//                     label: Text(
//                       'Name',
//                       style: GoogleFonts.inter(
//                           fontSize: 14, fontWeight: FontWeight.bold),
//                     )),
//                 DataColumn(
//                     label: Text('Email',
//                         style: GoogleFonts.inter(
//                             fontSize: 14, fontWeight: FontWeight.bold))),
//                 DataColumn(
//                     label: Text('Phone number',
//                         style: GoogleFonts.inter(
//                             fontSize: 14, fontWeight: FontWeight.bold))),
//                 DataColumn(
//                     label: Text('College',
//                         style: GoogleFonts.inter(
//                             fontSize: 14, fontWeight: FontWeight.bold))),
//                 DataColumn(
//                     label: Text('Department',
//                         style: GoogleFonts.inter(
//                             fontSize: 14, fontWeight: FontWeight.bold))),
//                 DataColumn(
//                     label: Text('Year',
//                         style: GoogleFonts.inter(
//                             fontSize: 14, fontWeight: FontWeight.bold))),
//               ],
//               rows: users.map((user) {
//                 return DataRow(
//                   cells: [
//                     DataCell(
//
//                       Text(
//                         user['Name'],
//                         style: GoogleFonts.inter(
//                           fontSize: 14,
//                         ),
//                       ),
//                       placeholder: false,
//                     ),
//                     DataCell(
//                       Text(
//                         user['Email'],
//                         style: GoogleFonts.inter(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     DataCell(
//                       Text(
//                         user['Phone number'],
//                         style: GoogleFonts.inter(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     DataCell(
//                       Text(
//                         user['College'],
//                         style: GoogleFonts.inter(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     DataCell(
//                       Text(
//                         user['Department'],
//                         style: GoogleFonts.inter(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     DataCell(
//                       Text(
//                         user['Year'],
//                         style: GoogleFonts.inter(
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                   // onTap: () {
//                   //   Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //       builder: (context) => StudentProgress(id: user.id),
//                   //     ),
//                   //   );
//                   // },
//                 );
//               }).toList(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }