import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard/Dashboardnew.dart';
import 'LoginOtpScreen.dart';
import 'UserOtpScreen.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({super.key});

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  //
  String id = '';
  String name = '';
  String email = '';
  String phone = '';
  String collage = '';
  String department = '';
  String Year = '';
  String status = '';

  //get data to mobile number
  void userLogin() async {
    final user = await FirebaseFirestore.instance
        .collection('UserRegister')
        .where('Phone number', isEqualTo: phoneController.text)
        .get();
    if (user.docs.isNotEmpty) {
      id = user.docs[0].id;
      name = user.docs[0]['Name'];
      email = user.docs[0]['Email'];
      phone = user.docs[0]['Phone number'];
      Year = user.docs[0]['Year'];
      collage = user.docs[0]['College'];
      department = user.docs[0]['Department'];

      user.docs[0]['status'];

      SharedPreferences data = await SharedPreferences.getInstance();
      data.setString('status', status);
      data.setString('id', id);
      data.setString('name', name);
      data.setString('email', email);
      data.setString('phone', phone);
      data.setString('collage', collage);
      data.setString('Year', Year);
      data.setString('Department', department);

      print(
          '<<<<<<<<<<<<<<<<<get data from shared preference>>>>>>>>>>>>>>>>>');

      mobscreen();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "invalid mobile number",
        style: TextStyle(color: Colors.red),
      )));
    }
  }

  //authenticationfunction
  Future<void> mobscreen() async {
    String phone = phoneController.text;
    String formattPhoneNumber = formatPhoneNumber(phone, '91');
    print(formattPhoneNumber);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: formattPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print("<<<<<>>>>>>>>>VerificationCompleted");
      },
      timeout: Duration(seconds: 10),
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        Fluttertoast.showToast(
            msg: "Verification code sent",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM);
        print("<<<<<<<<<<<go to otp screen>>>>>>>>>>>");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginOtp(
                verificationid: verificationId,
              ),
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //
  //
  //
  String formatPhoneNumber(String phoneNumber, String countryCode) {
    String digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return '+$countryCode$digits';
  }

  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
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
          Padding(
            padding: EdgeInsets.only(left: 50.w),
            child: Row(
              children: [
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800, fontSize: 30),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50.w),
            child: Row(
              children: [
                Text(
                  "Please sign in to continue",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 15),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.h, left: 50.w, right: 50.w),
            child: Container(
              decoration: BoxDecoration(color: Colors.white38),
              child: IntlPhoneField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  if (kDebugMode) {
                    print(phone.completeNumber);
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    userLogin();
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
                          "Login",
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
