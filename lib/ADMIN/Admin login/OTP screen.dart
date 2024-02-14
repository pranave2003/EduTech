import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../Youtube/Admin panal.dart';


class Otpscreen extends StatefulWidget {
  String verificationid;
  Otpscreen({super.key, required this.verificationid});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController otpcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 600,
          width: 500,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5.0,
                offset: const Offset(0.0, 5.0)),
          ], borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 200, width: 200, child: Image.asset('6333220.jpg')),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Verification Code',
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.purple),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please enter the ',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    Text(
                      'One Time Password',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                Text(
                  'To verify your account',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Pinput(
                    controller: otpcontroller,
                    keyboardType: TextInputType.number,
                    length: 6,
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            await PhoneAuthProvider.credential(
                                verificationId: widget.verificationid,
                                smsCode: otpcontroller.text.toString());
                        FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminDash(),
                              ));
                        });
                      } catch (ex) {
                        log(ex.toString());
                      }
                    },
                    child: Text('submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
