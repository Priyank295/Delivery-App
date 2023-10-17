import 'dart:convert';
import 'dart:io';

import 'package:DELIVERY_APP/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/bottom_navbar.dart';
import '../components/textField.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_typeahead/flutter_typeahead.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextEditingController _customer = new TextEditingController();
TextEditingController _item = new TextEditingController();
SuggestionsBoxController _controller2 = SuggestionsBoxController();
SuggestionsBoxController _controller = SuggestionsBoxController();

class _HomeScreenState extends State<HomeScreen> {
  String token = "";
  int count = 0;

  void add() {}

  List<String> items = [
    "Item1",
    "Item2",
    "Item3",
    "Item4",
    "Item5",
    "Item6",
    "Item7"
  ];

  void getToken() async {
    final SharedPreferences _token = await SharedPreferences.getInstance();
    token = _token.getString("token")!;
  }

  Future<void> _fetchData() async {
    var headers = {
      'Authorization': 'Bearer ${token}',
    };

    var response = await http.post(
        Uri.parse(
            'https://mmpl.vivekenterprise.org/public/api/change_password'),
        headers: headers);

    if (response.statusCode == 200) {
      print(json.decode(response.body));
    } else {
      print("Not fetching data");
      // Handle errors
    }
  }

  @override
  void initState() {
    getToken();
    _fetchData();
    // TODO: implement initState
    super.initState();
  }

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
            height: MediaQuery.of(context).size.height - 70,
            padding: EdgeInsets.all(24),
            child: Column(verticalDirection: VerticalDirection.down, children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            content: Text("Double tap to exit the app")));
                      },
                      onDoubleTap: () {
                        exit(0);
                      },
                      child: SvgPicture.asset("assets/back-arrow.svg"))
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: TypeAheadField(
                        // direction: AxisDirection.up,
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _customer,
                          autofocus: true,
                          // style: DefaultTextStyle.of(context)
                          //     .style
                          //     .copyWith(fontStyle: FontStyle.italic),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(129, 117, 117, 0.349),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(129, 117, 117, 0.349),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12)),
                            hintText: "Customer name",
                            contentPadding: EdgeInsets.only(left: 20, top: 15),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          // return await BackendService.getSuggestions(pattern);
                          return items;
                        },

                        hideOnEmpty: true,
                        suggestionsBoxController: _controller,
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          constraints: BoxConstraints(
                              maxHeight: 150, maxWidth: double.infinity),
                          hasScrollbar: true,
                          color: Colors.white,
                          elevation: 2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        noItemsFoundBuilder: (context) {
                          return Center(
                            child: Text("No data found"),
                          );
                        },

                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 16),
                                  child: Text(
                                    index,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            // subtitle: Text('\$${suggestion['price']}'),
                          );
                        },
                        onSuggestionSelected: (String suggestion) {
                          _customer.text = suggestion;
                          _controller.close();
                        },
                        // onSuggestionSelected: (suggestion) {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => ProductPage(product: suggestion)));
                        // },
                      ),
                    ),
                    SizedBox(height: 32),
                    Container(
                      height: 50,
                      child: TypeAheadField(
                        // direction: AxisDirection.up,
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _item,
                          autofocus: true,
                          // style: DefaultTextStyle.of(context)
                          //     .style
                          //     .copyWith(fontStyle: FontStyle.italic),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(129, 117, 117, 0.349),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(129, 117, 117, 0.349),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12)),
                            hintText: "Items",
                            contentPadding: EdgeInsets.only(left: 20, top: 15),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          // return await BackendService.getSuggestions(pattern);
                          return items;
                        },

                        hideOnEmpty: true,
                        suggestionsBoxController: _controller2,
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          constraints: BoxConstraints(
                              maxHeight: 150, maxWidth: double.infinity),
                          hasScrollbar: true,
                          color: Colors.white,
                          elevation: 2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        noItemsFoundBuilder: (context) {
                          return Center(
                            child: Text("No data found"),
                          );
                        },

                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 16),
                                  child: Text(
                                    index,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            // subtitle: Text('\$${suggestion['price']}'),
                          );
                        },
                        onSuggestionSelected: (String suggestion) {
                          _customer.text = suggestion;
                          _controller.close();
                        },
                        // onSuggestionSelected: (suggestion) {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => ProductPage(product: suggestion)));
                        // },
                      ),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Quantity",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            Material(
                              elevation: 8.0,
                              borderRadius: BorderRadius.circular(23),
                              child: Container(
                                height: 27,
                                width: 98,
                                decoration: BoxDecoration(
                                  color: Color(0xfff43A047),
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 22),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              count++;
                                            });
                                          },
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          count.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (count <= 0) {
                                              } else {
                                                count--;
                                              }
                                            });
                                          },
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    button(context, "Submit"),
                  ],
                ),
              ),

              // SingleChildScrollView(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       textField(context, "Customer Name"),
              //       SizedBox(
              //         height: 6,
              //       ),
              //       Container(
              //         height: 150,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(12),
              //           border: Border.all(
              //             color: Colors.black38,
              //           ),
              //         ),
              //         child: Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Container(
              //                 height: 40,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(12)),
              //                 child: Align(
              //                   alignment: Alignment.centerLeft,
              //                   child: Container(
              //                     margin: EdgeInsets.only(left: 16),
              //                     child: Text(
              //                       "Item-1",
              //                       style: TextStyle(
              //                           color: Colors.black, fontSize: 18),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 height: 40,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                     color: Color(0xfff43A047),
              //                     borderRadius: BorderRadius.circular(12)),
              //                 child: Align(
              //                   alignment: Alignment.centerLeft,
              //                   child: Container(
              //                     margin: EdgeInsets.only(left: 16),
              //                     child: Text(
              //                       "Item-2",
              //                       style: TextStyle(
              //                           color: Colors.white, fontSize: 18),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 height: 40,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(12)),
              //                 child: Align(
              //                   alignment: Alignment.centerLeft,
              //                   child: Container(
              //                     margin: EdgeInsets.only(left: 16),
              //                     child: Text(
              //                       "Item-3",
              //                       style: TextStyle(
              //                           color: Colors.black, fontSize: 18),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ]),
              //       ),
              //       SizedBox(
              //         height: 32,
              //       ),
              //       textField(context, "Item"),
              //       SizedBox(
              //         height: 6,
              //       ),
              //       Container(
              //         height: 150,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(12),
              //           border: Border.all(
              //             color: Colors.black38,
              //           ),
              //         ),
              //         child: Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Container(
              //                 height: 40,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(12)),
              //                 child: Align(
              //                   alignment: Alignment.centerLeft,
              //                   child: Container(
              //                     margin: EdgeInsets.only(left: 16),
              //                     child: Text(
              //                       "Item-1",
              //                       style: TextStyle(
              //                           color: Colors.black, fontSize: 18),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 height: 40,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                     color: Color(0xfff43A047),
              //                     borderRadius: BorderRadius.circular(12)),
              //                 child: Align(
              //                   alignment: Alignment.centerLeft,
              //                   child: Container(
              //                     margin: EdgeInsets.only(left: 16),
              //                     child: Text(
              //                       "Item-2",
              //                       style: TextStyle(
              //                           color: Colors.white, fontSize: 18),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 height: 40,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(12)),
              //                 child: Align(
              //                   alignment: Alignment.centerLeft,
              //                   child: Container(
              //                     margin: EdgeInsets.only(left: 16),
              //                     child: Text(
              //                       "Item-3",
              //                       style: TextStyle(
              //                           color: Colors.black, fontSize: 18),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ]),
              //       ),
              //       SizedBox(
              //         height: 19,
              //       ),
              //       Container(
              //         height: 50,
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //         child: Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 16),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Text(
              //                 "Quantity",
              //                 style: TextStyle(
              //                     fontSize: 16, color: Colors.black54),
              //               ),
              //               Container(
              //                 height: 27,
              //                 width: 98,
              //                 decoration: BoxDecoration(
              //                   color: Color(0xfff43A047),
              //                   borderRadius: BorderRadius.circular(26),
              //                 ),
              //                 child: Padding(
              //                   padding: EdgeInsets.symmetric(horizontal: 22),
              //                   child: Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.center,
              //                       children: [
              //                         InkWell(
              //                           onTap: () {
              //                             setState(() {
              //                               count++;
              //                             });
              //                           },
              //                           child: Text(
              //                             "+",
              //                             style: TextStyle(
              //                                 fontSize: 16,
              //                                 color: Colors.white,
              //                                 fontWeight: FontWeight.bold),
              //                           ),
              //                         ),
              //                         Text(
              //                           count.toString(),
              //                           style: TextStyle(
              //                               color: Colors.white,
              //                               fontSize: 16,
              //                               fontWeight: FontWeight.bold),
              //                         ),
              //                         InkWell(
              //                           onTap: () {
              //                             setState(() {
              //                               if (count <= 0) {
              //                               } else {
              //                                 count--;
              //                               }
              //                             });
              //                           },
              //                           child: Text(
              //                             "-",
              //                             style: TextStyle(
              //                                 color: Colors.white,
              //                                 fontSize: 16,
              //                                 fontWeight: FontWeight.bold),
              //                           ),
              //                         ),
              //                       ]),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 30,
              //       ),
              //       button(context, "Submit"),
              //     ],
              //   ),
              // ),
            ]),
          ),
        ),
      ),
    );
  }
}
