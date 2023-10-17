import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import '../components/bottom_navbar.dart';
import '../components/textField.dart';
import '../components/widgets.dart';

class MyCartScreen extends StatefulWidget {
  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  List<CartDetails> cartList = [
    CartDetails("Item Name", "Delivered on Aug 31, Sunday", 102.00, 1),
    CartDetails("Item Name", "Delivered on Aug 31, Sunday", 102.00, 1),
    CartDetails("Item Name", "Delivered on Aug 31, Sunday", 102.00, 1),
    CartDetails("Item Name", "Delivered on Aug 31, Sunday", 102.00, 1),
    CartDetails("Item Name", "Delivered on Aug 31, Sunday", 102.00, 1),
    CartDetails("Item Name", "Delivered on Aug 31, Sunday", 102.00, 1),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xfff43A047),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
            color: Color(0xfffFFF9C5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(48),
              topRight: Radius.circular(48),
            ),
          ),
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 70),
            width: double.infinity,
            child: Column(children: [
              Stack(children: [
                Padding(
                  padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                  // padding: const EdgeInsets.all(8.0),
                  child: Row(
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
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "MY CART",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ]),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  return cartList.length == 0
                      ? Center(
                          child: Text("Cart is Empty"),
                        )
                      : Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Material(
                            elevation: 8.0,
                            borderRadius: BorderRadius.circular(23),
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xfffEAEFF8),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(23),
                                            bottomLeft: Radius.circular(23))),
                                    height: 120,
                                    width: 128,
                                    child: Image.asset(
                                      'assets/car3.png',
                                      filterQuality: FilterQuality.high,
                                      // color: Color(0xfffEAEFF8),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 138,
                                    // padding: EdgeInsets.all(7),
                                    height: 120,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(top: 3),
                                            height: 30,
                                            child: Text(
                                              cartList[index].name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 2.5),
                                            child: Text(
                                              cartList[index].date,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Text(
                                            "\$" +
                                                cartList[index]
                                                    .price
                                                    .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    cartList.removeAt(index);
                                                  });
                                                },
                                                child: Container(
                                                  height: 20,
                                                  width: 67,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xfff43A047),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/bin.svg"),
                                                        Text(
                                                          "Remove",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ]),
                                                ),
                                              ),

                                              // Spacer(),
                                              Container(
                                                height: 27,
                                                width: 98,
                                                decoration: BoxDecoration(
                                                  // color: Color(0xfff43A047),
                                                  borderRadius:
                                                      BorderRadius.circular(26),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 22),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if (cartList[index]
                                                                    .count <=
                                                                0) {
                                                            } else {
                                                              setState(() {
                                                                cartList[index]
                                                                    .count--;
                                                              });
                                                            }
                                                          },
                                                          child: Text(
                                                            "-",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Text(
                                                          cartList[index]
                                                              .count
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              cartList[index]
                                                                  .count++;
                                                            });
                                                          },
                                                          child: Text(
                                                            "+",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          )
                                        ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                },
              ),
              // itemCard(context),
              // itemCard(context),
              // itemCard(context),
              // itemCard(context),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(context, "Place Order"),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class CartDetails {
  String name, date;
  double price;
  int count;

  CartDetails(this.name, this.date, this.price, this.count);
}
