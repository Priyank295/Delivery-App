import 'dart:io';

import 'package:DELIVERY_APP/components/bottom_navbar.dart';
import 'package:DELIVERY_APP/screens/changePasswordScreen.dart';
import 'package:DELIVERY_APP/screens/myLeaveScreen.dart';
import 'package:DELIVERY_APP/screens/orderDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/widgets.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  var rowSpacer = TableRow(children: [
    SizedBox(
      height: 10,
    ),
    SizedBox(
      height: 10,
    ),
    SizedBox(
      height: 10,
    )
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff43A047),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
            color: Color(0xfffFFF9C5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48),
              topRight: Radius.circular(48),
            ),
          ),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                new SnackBar(
                                    content:
                                        Text("Double tap to exit the app")));
                          },
                          onDoubleTap: () {
                            exit(0);
                          },
                          child: SvgPicture.asset("assets/back-arrow.svg")),
                      Text(
                        "MY PROFILE",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //   "Edit",
                      //   style: TextStyle(
                      //       fontFamily: 'Poppins',
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w600),
                      // ),
                      PopupMenuButton(
                        onSelected: (value) {
                          if (value == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => OrderDetailScreen()));
                          } else if (value == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => MyLeaveScreen()));
                          } else if (value == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => ChangePasswordScreen()));
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            onTap: () {},
                            child: Text("My Orders Details"),
                          ),
                          PopupMenuItem(
                            value: 2,
                            onTap: () {},
                            child: Text("My Leaves"),
                          ),
                          PopupMenuItem(
                            value: 3,
                            onTap: () {},
                            child: Text("Change Password"),
                          ),
                          PopupMenuItem(
                            value: 3,
                            onTap: () {},
                            child: Text("Edit"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/profile-avatar.png",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 65),
                  child: Column(
                    children: [
                      Row(children: [
                        SvgPicture.asset("assets/phone.svg"),
                        SizedBox(
                          width: 17,
                        ),
                        Text(
                          "+91 xxxxxxx194",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        )
                      ]),
                      SizedBox(
                        height: 28,
                      ),
                      Row(children: [
                        SvgPicture.asset("assets/mail.svg"),
                        SizedBox(
                          width: 17,
                        ),
                        Text(
                          "yourgmail.com",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        )
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("12",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Text("Ordered",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87)),
                        ],
                      ),
                      Container(
                        height: double.infinity,
                        width: 1,
                        color: Colors.black45,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("5",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Text("Delivery",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87)),
                        ],
                      ),
                    ],
                  ),
                ),
                //TOTAL ORDER
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: Text(
                      "TOTAL ORDER",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                //TABLE OF ORDERS
                Material(
                  color: Colors.transparent,
                  elevation: 8.0,
                  child: Container(
                      padding: EdgeInsets.only(top: 28),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(23)),
                      width: double.infinity,
                      height: 200,
                      child: Table(
                        defaultColumnWidth: FixedColumnWidth(
                            MediaQuery.of(context).size.width / 3),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfffB9EDBB),
                              ),
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  constraints: BoxConstraints(minHeight: 40),
                                  child: Center(
                                      child: Text(
                                    "Product Name",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                                Container(
                                  constraints: BoxConstraints(minHeight: 40),
                                  child: Center(
                                      child: Text(
                                    "Quantity",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                                Container(
                                  constraints: BoxConstraints(minHeight: 40),
                                  child: Center(
                                      child: Text(
                                    "Total Price",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                )
                              ]),
                          rowSpacer,
                          TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xfffd9d9d9),
                              ),
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    "Lorem Ipsum",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                                Container(
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    "100",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                                Container(
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    "\$102:00",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                                )
                              ]),
                          rowSpacer,
                          TableRow(decoration: BoxDecoration(), children: [
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              height: 30,
                              child: Center(
                                  child: Text(
                                "Lorem Ipsum",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                            Container(
                              height: 30,
                              child: Center(
                                  child: Text(
                                "100",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )),
                            ),
                            Container(
                              height: 30,
                              child: Center(
                                  child: Text(
                                "\$102:00",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              )),
                            )
                          ]),
                          rowSpacer,
                          TableRow(decoration: BoxDecoration(), children: [
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              height: 30,
                              child: Center(
                                  child: Text(
                                "Lorem Ipsum",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                            Container(
                              height: 30,
                              child: Center(
                                  child: Text(
                                "100",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                            Container(
                              height: 30,
                              child: Center(
                                  child: Text(
                                "\$102:00",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                            )
                          ]),
                          rowSpacer,
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
