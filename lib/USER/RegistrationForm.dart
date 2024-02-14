import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:excel/excel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard/Dashboardnew.dart';

class RegistrationFoarm extends StatefulWidget {
  const RegistrationFoarm({super.key});

  @override
  State<RegistrationFoarm> createState() => _RegistrationFoarmState();
}

class _RegistrationFoarmState extends State<RegistrationFoarm> {
  var mob = '';
  void initState() {
    getData();
  }

  var Name;
  var Mobile;
  var department;
  var Email;
  var Year;
  var college;

  Future<void> setData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    Name = name.text;
    Mobile = mob.simplifyText();
    Email = email.toString();
    department = selectedDepartmentValue.toString();
    college = selectedcollegeValue.toString();
    Year = SelectedYear.toString();

    setState(() {
      spref.setString("name", Name);
      spref.setString("phone", Mobile);
      spref.setString("email", Email.toString());
      spref.setString("collage", college);
      spref.setString("Department", department);
      spref.setString("Year", Year);
      print("<<<<<<<<<<<<<<<sharedprefrencedataadded>>>>>>>>>>>>>>>");
      print("sharepfr:$Name");
      print("shareprf:$Mobile");
      print("Shareprf$Email");
    });
    print("Updated");
  }

//
//
  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      mob = spref.getString("num")!;
      spref.setString("id", mob);
    });
    //

    print("sp Updated");
  }

  Future<dynamic> register() async {
    await FirebaseFirestore.instance.collection('UserRegister').add({
      "Name": name.text,
      "Email": email.text,
      "Phone number": mob,
      "College": selectedcollegeValue,
      "Department": selectedDepartmentValue,
      "Year": SelectedYear,
    });

    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ));
    print("Register sucsess");
  }

  //=======================================================================================================

  final _formfield = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var phonenumber = TextEditingController();

  bool passToggle = true;

  var selectedGender;

  final List<String> collegeItems = [
    'KMO College',
    'KMO ITI',
  ];

  final List<String> departmentitem = [
    'B.A/.L.L.B. (Law)',
    'BBA',
    'BCA',
    'Bcom',
    'Bachelor of Architecture',
  ];

  final List<String> yearlist = [
    '1 year',
    '2 year',
    '3 year',
  ];

  String? selectedDepartmentValue;
  String? SelectedYear;
  String? selectedcollegeValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f6f9),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              surfaceTintColor: Color(0xfff5f6f9),
              backgroundColor: Color(0xfff5f6f9),
              expandedHeight: 151.0.h,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.only(left: 0).r,
                title: Text(
                  'REGISTER',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 19.sp,
                      color: Colors.black),
                ),
                background: Image.asset("assets/EMPLOYIBILITY.png"),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // Build your list items here
                  return Form(
                    key: _formfield,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20).r,
                          child: Text(
                            'Name',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30, right: 30, top: 5)
                                  .r,
                          child: TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter Name',
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff878787)),
                                contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15)
                                    .r,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff878787)),
                                  borderRadius: BorderRadius.circular(8).r,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff878787)),
                                  borderRadius: BorderRadius.circular(8).r,
                                ),
                                border: const OutlineInputBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Name";
                              }
                            },
                          ),
                        ),

                        //============================================================================================================================

                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15).r,
                          child: Text(
                            'E-mail',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30, right: 30, top: 5)
                                  .r,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: email,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter E-mail',
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff878787)),
                                contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15)
                                    .r,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff878787)),
                                  borderRadius: BorderRadius.circular(8).r,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff878787)),
                                  borderRadius: BorderRadius.circular(8).r,
                                ),
                                border: const OutlineInputBorder()),
                            validator: (value) {
                              bool emailvalid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);

                              if (value!.isEmpty) {
                                return "Enter Email";
                              } else if (!emailvalid) {
                                return "Enter Valied Email";
                              }
                            },
                          ),
                        ),

                        //============================================================================================================================

                        //=======================================================================================================================================================

                        //=======================================================================================================================================================

                        //=======================================================================================================================================================

                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15).r,
                          child: Text(
                            'College',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 17.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 5),
                          child: SizedBox(
                            height: 70,
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,

                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(8).r,
                                ),
                                // Add more decoration..
                              ),
                              hint: const Text(
                                'Select Your College',
                                style: TextStyle(fontSize: 14),
                              ),
                              items: collegeItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedcollegeValue = value.toString();
                                  print(selectedcollegeValue);
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 24,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an College';
                                }
                                return null;
                              },
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                        ),

                        //======================================================================================================================================

                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15).r,
                          child: Text(
                            'Department',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                                color: Colors.black),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 5),
                          child: SizedBox(
                            height: 70,
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(8).r,
                                ),
                                // Add more decoration..
                              ),
                              hint: const Text(
                                'Select Your department',
                                style: TextStyle(fontSize: 14),
                              ),
                              items: departmentitem
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDepartmentValue = value.toString();
                                  print(selectedDepartmentValue);
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 24,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an Department';
                                }
                                return null;
                              },
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                        ),

                        //======================================================================================================================================

                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15).r,
                          child: Text(
                            'Year',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 17.sp,
                                color: Colors.black),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 5),
                          child: SizedBox(
                            height: 70,
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff878787)),
                                  borderRadius: BorderRadius.circular(8).r,
                                ),
                                // Add more decoration..
                              ),
                              hint: const Text(
                                'Select Year',
                                style: TextStyle(fontSize: 14),
                              ),
                              items: yearlist
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  SelectedYear = value.toString();
                                  print(SelectedYear);
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 24,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an Year';
                                }
                                return null;
                              },
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              if (_formfield.currentState!.validate()) {
                                setData();
                                register();
                              } else
                                print("Faild");
                            },
                            child: Container(
                              height: 40.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: Colors.purple),
                              child: Center(
                                child: Text(
                                  'REGISTER',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.sp,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  );
                },
                childCount: 1, // Change this to the number of items you want
              ),
            )
          ],
        ));
  }
}
