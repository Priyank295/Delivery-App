import 'dart:convert';

import 'package:DELIVERY_APP/models/leaveDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/bottom_navbar.dart';

class MyLeaveScreen extends StatefulWidget {
  const MyLeaveScreen({super.key});

  @override
  State<MyLeaveScreen> createState() => _MyLeaveScreenState();
}

String _responseData = "";

late Map map;
List<LeaveDetailsModel> list = [];

class _MyLeaveScreenState extends State<MyLeaveScreen> {
  Future<List<dynamic>> _fetchData() async {
    final pref = await SharedPreferences.getInstance();
    final String url =
        'https://mmpl.vivekenterprise.org/public/api/getLeaveList';
    final String? userToken = pref.getString("token");

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $userToken',
    });

    if (response.statusCode == 200) {
      final _body = await json.decode(response.body)['data'];

      return _body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.all(24),
                  // padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset("assets/back-arrow.svg")),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "MY LEAVE",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(
                height: 19,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        "Request",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Status",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 5),
              //   height: 2,
              //   width: double.infinity,
              //   color: Colors.black45,
              // ),
              Stack(
                children: [
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black45,
                  ),
                  Container(
                    height: 2,
                    width: 144,
                    color: Colors.black,
                  )
                ],
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: FutureBuilder<List<dynamic>>(
                    future: _fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (ctx, i) {
                              return RequestCard(context, snapshot.data![i]);
                            });
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        child: Column(
          children: [
            // RequestCard(context, true),
            // RequestCard(context, false),
            // RequestCard(context, true),
          ],
        ));
  }
}

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

String getDayName(DateTime date) {
  return DateFormat('EEE').format(date);
}

String getMonthName(DateTime date) {
  return DateFormat('MMM').format(date);
}

Widget RequestCard(BuildContext context, Map data) {
  DateTime start = DateTime.parse(data['start_date']);
  DateTime end = DateTime.parse(data['end_date']);

  String startDay = getDayName(start);
  String endDay = getDayName(end);

  String startMon = getMonthName(start);
  String endMon = getMonthName(end);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  startDay +
                      ", " +
                      start.day.toString() +
                      " " +
                      startMon +
                      " " +
                      start.year.toString(),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  endDay +
                      ", " +
                      end.day.toString() +
                      " " +
                      startMon +
                      " " +
                      start.year.toString(),
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['status'],
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: data['status'] == "Declined"
                          ? Colors.red
                          : Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
      Text(data['reason']),
      SizedBox(
        height: 30,
      ),
    ],
  );
}
