import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:DELIVERY_APP/components/bottom_navbar.dart';
import 'package:DELIVERY_APP/screens/homeScreen.dart';
import 'package:DELIVERY_APP/screens/myCartScreen.dart';
import 'package:DELIVERY_APP/screens/myProfileScreen.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

void background() async {
  try {
    var status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 1,
            forceAlarmManager: false,
            stopOnTerminate: false,
            startOnBoot: true,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.NONE),
        _onBackgroundFetch,
        _onBackgroundFetchTimeout);
    print('[BackgroundFetch] configure success: $status');

    // Schedule a "one-shot" custom-task in 10000ms.
    // These are fairly reliable on Android (particularly with forceAlarmManager) but not iOS,
    // where device must be powered (and delay will be throttled by the OS).

    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "com.transistorsoft.customtask",
        delay: 10,
        periodic: false,
        forceAlarmManager: true,
        stopOnTerminate: false,
        enableHeadless: true));
  } on Exception catch (e) {
    print("[BackgroundFetch] configure ERROR: $e");
  }
}

void _onBackgroundFetch(String taskId) async {
  var prefs = await SharedPreferences.getInstance();
  var timestamp = DateTime.now();
  // This is the fetch-event callback.
  // print("[BackgroundFetch] Event received: $taskId");
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  Timer.periodic(Duration(seconds: 20), (timer) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      String address =
          '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      prefs.setString("longitude", position.longitude.toString());
      prefs.setString("latitude", position.latitude.toString());
      prefs.setString("address", address);

      addCurrrentLocation(
          position.longitude.toString(), position.latitude.toString(), address);
    } catch (e) {
      print(e);
    }
  });

  // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
  // for taking too long in the background.
  BackgroundFetch.finish(taskId);
}

Future<void> addCurrrentLocation(
    String longitude, String latitude, String address) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();

  String userToken = "";

  userToken = pref.getString("token")!;

  try {
    final url = Uri.parse(
        "https://mmpl.vivekenterprise.org/public/api/addCurrentLocation");
    Map<String, String> requestBody = <String, String>{
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
    };
    // final SharedPreferences token = await userToken;
    var request = http.MultipartRequest(
      'POST',
      url,
    )..fields.addAll(requestBody);
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $userToken',
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(
      jsonDecode(respStr),
    );
    print("This is the Status Code$respStr");
    var encoded = json.decode(respStr);

    // if (encoded['status'] == true) {
    //   userToken.setString("token", encoded['token']);
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (ctx) => BottomNavBarScreen()));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    //       content: Text("Please check your username and password")));
    // }
    // print(encoded['status']);
    // print('This is the userId${encoded['data']['user_id']}');
  } catch (error) {
    print(error);
  }
}

void _onBackgroundFetchTimeout(String taskId) {
  print("[BackgroundFetch] TIMEOUT: $taskId");
  BackgroundFetch.finish(taskId);
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  String? _currentAddress;
  Position? _currentPosition;
  bool location = false;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getCurrentPosition() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    // if (!isLocationEnabled) {
    //   // Request location service
    //   isLocationEnabled = await Geolocator.requestPermission();
    //   if (!isLocationEnabled) {
    //     return null;
    //   }
    // }
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  getValue() async {
    var lon = await _currentPosition;
    // var lat = await _currentPosition!.latitude;
    location = await _handleLocationPermission();
    print(lon);
    // print(lat);
  }

  @override
  void initState() {
    // TODO: implement initState
    background();
    _getCurrentPosition();
    getValue();
    super.initState();
  }

  int page_index = 0;
  final pages = [
    HomeScreen(),
    MyCartScreen(),
    MyProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return !location
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              // child: Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 30),
              //   child: Text(
              //       textAlign: TextAlign.center,
              //       "Your Location Services are disable or you deny location permissions. please go to settings and give app to location permissions."),
              // ),
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: pages[page_index],
            bottomNavigationBar: Container(
              color: Colors.transparent,
              height: 60,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 6.0,
                            ), //B
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                page_index = 0;
                              });
                            },
                            child: page_index == 0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xfff43A047),
                                          border: Border.all(
                                              color: Colors.white, width: 4.5),
                                        ),
                                        height: 44,
                                        width: 44,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/home.svg",
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Home",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // IconButton(
                                      //   enableFeedback: false,
                                      //   onPressed: () {
                                      //     setState(() {
                                      //       page_index = 0;
                                      //     });
                                      //   },
                                      //   icon:
                                      // ),
                                      SvgPicture.asset(
                                        "assets/home.svg",
                                        height: 27,
                                        width: 35,
                                      ),
                                      Text(
                                        "Home",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xfffABABAB),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        Align(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                page_index = 1;
                              });
                            },
                            child: page_index == 1
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(bottom: 20),
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xfff43A047),
                                          border: Border.all(
                                              color: Colors.white, width: 4.5),
                                        ),
                                        height: 44,
                                        width: 44,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/cart.svg",
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Cart",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // IconButton(
                                      //   enableFeedback: false,
                                      //   onPressed: () {
                                      //     setState(() {
                                      //       page_index = 0;
                                      //     });
                                      //   },
                                      //   icon:
                                      // ),
                                      SvgPicture.asset(
                                        "assets/cart.svg",
                                        height: 27,
                                        width: 35,
                                      ),
                                      Text(
                                        "Cart",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xfffABABAB),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        Align(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                page_index = 2;
                              });
                            },
                            child: page_index == 2
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xfff43A047),
                                          border: Border.all(
                                              color: Colors.white, width: 4.5),
                                        ),
                                        height: 44,
                                        width: 44,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/profile.svg",
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Profile",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // IconButton(
                                      //   enableFeedback: false,
                                      //   onPressed: () {
                                      //     setState(() {
                                      //       page_index = 0;
                                      //     });
                                      //   },
                                      //   icon:
                                      // ),
                                      SvgPicture.asset(
                                        "assets/profile.svg",
                                        height: 27,
                                        width: 35,
                                      ),
                                      Text(
                                        "Profile",
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xfffABABAB),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
