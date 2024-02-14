import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard/Dashboardnew.dart';
import 'Premium/pro Dashboard.dart';

class LoginOtp extends StatefulWidget {
  String verificationid = '';
  LoginOtp({
    required this.verificationid,
    super.key,
  });

  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  TextEditingController Getotp = TextEditingController();
  //
  //

  Future<void> verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationid,
        smsCode: Getotp.text,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      print("<<<<<<<<<<<<<go dashboard>>>>>>>>>>>>");
      if (status == "1") {
        print('<<<<<<<<<<<<<<<<<<<<<pro>>>>>>>>>>>>>>>>>>>>>');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PremiumDash(),
          ),
        );
      } else {
        print('object');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during OTP validation: $e");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP. Please try again."),
          duration: Duration(seconds: 10),
        ),
      );
    }
  }

  //
  //

  void initState() {
    getData();
  }

  String status = '';

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      status = spref.getString("status")!;

      spref.setString('status', status);
      print('status=$status');
    });
    print("Updated");
  }

  @override
  Widget build(BuildContext context) {
    String otp;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios))),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    image: DecorationImage(
                        image: AssetImage("assets/logmobile.jpg"),
                        fit: BoxFit.fill)),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Verification Code",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w800, fontSize: 30),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please sign in to continue",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 15),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Pinput(
                keyboardType: TextInputType.number,
                length: 6,
                controller: Getotp),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    verifyOtp();
                  },
                  child: Container(
                    height: 50.h,
                    width: 250.w,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5.0,
                              offset: const Offset(0.0, 3.0)),
                        ]),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Verify",
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

TextEditingController Getotp = TextEditingController();
