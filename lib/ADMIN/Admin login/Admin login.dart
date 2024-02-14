
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:responsive_layout/app_colors.dart';
// import 'package:responsive_layout/app_icons.dart';
// import 'package:responsive_layout/app_styles.dart';
// import 'package:responsive_layout/responsive_widget.dart';

import 'Phoneauth.dart';
import 'app colors.dart';
import 'app stayles.dart';
import 'responsive.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({Key? key}) : super(key: key);

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  final _formfield = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: SizedBox(
        height: height,
        width: width,
        child: Form(
          key: _formfield,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ResponsiveWidget.isSmallScreen(context)
                  ? const SizedBox()
                  : Expanded(
                      child: Container(
                        height: height,
                        color: Colors.purple,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                'assets/educationapplog-removebg-preview.png'),
                            Text(
                              // 'AdminExpress',
                              'EduPort',
                              style: ralewayStyle.copyWith(
                                fontSize: 49.0,
                                color: Colors.purple[100],
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Expanded(
                child: Container(
                  height: height,
                  margin: EdgeInsets.symmetric(
                      horizontal: ResponsiveWidget.isSmallScreen(context)
                          ? height * 0.032
                          : height * 0.12),
                  color: Colors.purple[100],
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.2),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: '',
                                  style: ralewayStyle.copyWith(
                                    fontSize: 25.0,
                                    color: AppColors.blueDarkColor,
                                    fontWeight: FontWeight.normal,
                                  )),
                              TextSpan(
                                text: 'Login 👇',
                                style: ralewayStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.blueDarkColor,
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          'Hey, Enter your details to get login \nto your account.',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                          ),
                        ),
                        SizedBox(height: height * 0.064),

                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Email',
                            style: ralewayStyle.copyWith(
                              fontSize: 12.0,
                              color: AppColors.blueDarkColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        TextFormField(
                          controller: email,

                          decoration: InputDecoration(
                              fillColor: AppColors.whiteColor,
                              suffixIcon: Icon(Icons.email),
                              filled: true,
                              hintText: 'Enter E-mail',
                              hintStyle: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.blueDarkColor.withOpacity(0.5),
                                fontSize: 12.0,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15)
                                  .r,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.blueDarkColor),
                                borderRadius: BorderRadius.circular(8).r,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color:AppColors.blueDarkColor),
                                borderRadius: BorderRadius.circular(8).r,
                              ),
                              border: const OutlineInputBorder()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            } else if (email.text!='kmo@gmail.com') {
                              return "E-mail don't match";
                            }
                          },
                        ),

                        SizedBox(height: height * 0.014),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Password',
                            style: ralewayStyle.copyWith(
                              fontSize: 12.0,
                              color: AppColors.blueDarkColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        TextFormField(
                          controller: password,
                          obscureText: passToggle,
                          decoration: InputDecoration(
                              fillColor: AppColors.whiteColor,
                              filled: true,
                              hintText: 'Enter Password',
                              hintStyle: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.blueDarkColor.withOpacity(0.5),
                                fontSize: 12.0,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passToggle = !passToggle;
                                  });
                                },
                                child: Icon(passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15)
                                  .r,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: AppColors.blueDarkColor),
                                borderRadius: BorderRadius.circular(8).r,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color:AppColors.blueDarkColor),
                                borderRadius: BorderRadius.circular(8).r,
                              ),
                              border: const OutlineInputBorder()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            } else if (password.text!='kmo123') {
                              return "Password don't match";
                            }
                          },
                        ),


                        SizedBox(height: height * 0.05),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (_formfield.currentState!.validate()) {
                                if (email.text == 'kmo@gmail.com'&&
                                    password.text == 'kmo123') {
                                  print("click");
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Phoneauth();

                                    },
                                  ));
                                }
                              }
                            },
                            borderRadius: BorderRadius.circular(16.0),
                            child: Ink(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70.0, vertical: 18.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.purple
                              ),
                              child: Text(
                                'Login',
                                style: ralewayStyle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.purple[100],
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
