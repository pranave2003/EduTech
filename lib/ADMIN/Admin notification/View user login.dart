import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'View user profile.dart';


class Viewuserlogin extends StatefulWidget {
  const Viewuserlogin({super.key});

  @override
  State<Viewuserlogin> createState() => _ViewuserloginState();
}

class _ViewuserloginState extends State<Viewuserlogin> {

  bool startAnimation = false;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title:GestureDetector(
            onTap: () {
              // Future.delayed(const Duration(milliseconds: 500), () {
              //   setState(() {
              //     startAnimation = true;
              //   });
              // });
            },
            child: const Text(
              "All Students",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          )
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("UserRegister").get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            final user = snapshot.data?.docs ?? [];

            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100, top: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>Viewuserprofile(id:user[index].id),
                          ));
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5.0,
                                offset: const Offset(0.0, 5.0)),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.purple[50]),
                      child: Center(
                        child: ListTile(
                          leading: Image.network(
                              'https://cdn0.iconfinder.com/data/icons/kameleon-free-pack-rounded/110/Student-3-1024.png'),
                          title: Text(
                            user[index]['Name'],
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                            user[index]['Department'],
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: user.length,
            );
          } ),
    );
  }



}
