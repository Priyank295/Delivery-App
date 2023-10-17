import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget button(BuildContext context, String name) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    width: double.infinity,
    height: 49,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Color(0xfff43A047),
    ),
    child: Center(
      child: Text(
        name,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  );
}

Widget itemCard(BuildContext context) {
  return Container(
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
              height: 120,
              width: 128,
              child: Image.asset('assets/car3.png',
                  filterQuality: FilterQuality.high),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 128,
              // padding: EdgeInsets.all(7),
              height: 120,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      child: Text(
                        "Item Name",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Delivered on Aug 31, Sunday",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "\$102:00",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 20,
                          width: 67,
                          decoration: BoxDecoration(
                              color: Color(0xfff43A047),
                              borderRadius: BorderRadius.circular(7)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/bin.svg"),
                                Text(
                                  "Remove",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                        ),

                        // Spacer(),
                        Container(
                          height: 27,
                          width: 98,
                          decoration: BoxDecoration(
                            // color: Color(0xfff43A047),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "-",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "1",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "+",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
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
}

Widget redBtn(BuildContext context, String name) {
  return Container(
    height: 50,
    width: 200,
    decoration: BoxDecoration(color: Colors.red),
    child: Center(child: Text(name)),
  );
}

Widget orderDetailsCard(BuildContext context) {
  return Column(
    children: [
      Container(
        constraints: BoxConstraints(minHeight: 98),
        width: double.infinity,
        child: Row(
          children: [
            Image.asset(
              "assets/car3.png",
              height: 98,
              width: 98,
            ),
            Padding(
              padding: EdgeInsets.only(right: 40, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // padding: EdgeInsets.only(right: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 148,
                      child: Text(
                        "Delivered on Aug 31, Sunday",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Text(
                    "Product name",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),

                  // Container(
                  //   child: Container(
                  //     padding: EdgeInsets.only(top: 40),
                  //     child: Text(
                  //       'Thank you for letting me do what I love, your support is contagious If I could put all 10,000 of you in a room and give you all a hug I WOULD. Your support makes my heart grow and glow. Thank you for helping me create a business and a family.I love you all 🌈',
                  //     ),
                  //     width: MediaQuery.of(context).size.width * 0.6,
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        height: 1,
        width: double.infinity,
        color: Colors.black38,
      ),
      SizedBox(
        height: 5,
      )
    ],
  );
}
