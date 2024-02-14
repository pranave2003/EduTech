import 'package:eduapp/USER/Premium/premium%20VedioPlayList/pro%20VedioCatergories.dart';
import 'package:eduapp/USER/Premium/pro%20notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LOGIN SCREEN.dart';

class PremiumDash extends StatefulWidget {
  const PremiumDash({super.key});

  @override
  State<PremiumDash> createState() => _PremiumDashState();
}

class _PremiumDashState extends State<PremiumDash> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MobileLogin()));
  }

  var Name1;
  var Mobile;
  var department;
  var Email;
  var Year;
  var college;
  void initState() {
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      Name1 = spref.getString('name');
      Email = spref.getString("email");
      Mobile = spref.getString("phone");
      college = spref.getString("collage");
      department = spref.getString("Department");
      Year = spref.getString("Year");

      spref.setString('name', Name1);
      spref.setString("email", Email);
      spref.setString("phone", Mobile);
      spref.setString("collage", college);
      spref.setString("Department", department);
      spref.setString("Year", Year);
    });
    print("Updated");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text("Hi..",
                  style: GoogleFonts.poppins(
                      color: Colors.blue.shade700,
                      fontSize: 30,
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 10),
              Text(Name1,
                  style: GoogleFonts.poppins(
                      color: Colors.blue.shade900,
                      fontSize: 30,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          backgroundColor: Colors.blue.shade100,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProNotification(),
                      ));
                },
                icon: Icon(
                  Icons.notifications_active,
                  color: Colors.blue,
                ))
          ]),
      bottomSheet: Container(
        height: 60,
        color: Colors.white,
        child: Row(children: [
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.blue,
                size: 30,
              )),
        ]),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.blue.shade200.withOpacity(0.5), // color of shadow
                  spreadRadius: 2, // spread radius
                  blurRadius: 2, // blur radius
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  height: 60,
                  width: 60,
                  child: Lottie.asset('assets/premium.json',
                      height: 100, width: 100, fit: BoxFit.fill),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Column(
                children: [
                  Text(
                    "Unlocked",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w800),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Premium membership",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue.shade200,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => proVedioCategory(),
                  ));
            },
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade100
                        .withOpacity(0.5), // color of shadow
                    spreadRadius: 2, // spread radius
                    blurRadius: 2, // blur radius
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Container(
                    height: 120,
                    width: 110,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/EMPLOYIBILITY.png"),
                            fit: BoxFit.fill),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Employibility",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                )
              ]),
            ),
          ),
        )
      ]),
    );
  }
}
