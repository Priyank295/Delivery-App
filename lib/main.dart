import 'dart:async';
import 'dart:convert';
import 'package:DELIVERY_APP/screens/navbarScreen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/loginScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:background_fetch/background_fetch.dart';

@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  var taskId = task.taskId;
  var timeout = task.timeout;
  if (timeout) {
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }

  print("[BackgroundFetch] Headless event received: $taskId");

  var prefs = await SharedPreferences.getInstance();

  // Read fetch_events from SharedPreferences

  if (taskId == 'flutter_background_fetch') {
    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "com.transistorsoft.customtask",
        delay: 5000,
        periodic: false,
        forceAlarmManager: false,
        stopOnTerminate: false,
        enableHeadless: true));
  }
  BackgroundFetch.finish(taskId);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  runApp(MyApp());
//   try {
//     var status = await BackgroundFetch.configure(
//         BackgroundFetchConfig(
//             minimumFetchInterval: 1,
//             forceAlarmManager: false,
//             stopOnTerminate: false,
//             startOnBoot: true,
//             enableHeadless: true,
//             requiresBatteryNotLow: false,
//             requiresCharging: false,
//             requiresStorageNotLow: false,
//             requiresDeviceIdle: false,
//             requiredNetworkType: NetworkType.NONE),
//         _onBackgroundFetch,
//         _onBackgroundFetchTimeout);
//     print('[BackgroundFetch] configure success: $status');

//     // Schedule a "one-shot" custom-task in 10000ms.
//     // These are fairly reliable on Android (particularly with forceAlarmManager) but not iOS,
//     // where device must be powered (and delay will be throttled by the OS).

//     BackgroundFetch.scheduleTask(TaskConfig(
//         taskId: "com.transistorsoft.customtask",
//         delay: 10,
//         periodic: false,
//         forceAlarmManager: true,
//         stopOnTerminate: false,
//         enableHeadless: true));
//   } on Exception catch (e) {
//     print("[BackgroundFetch] configure ERROR: $e");
//   }
// }

// void _onBackgroundFetch(String taskId) async {
//   var prefs = await SharedPreferences.getInstance();
//   var timestamp = DateTime.now();
//   // This is the fetch-event callback.
//   // print("[BackgroundFetch] Event received: $taskId");
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   Timer.periodic(Duration(seconds: 20), (timer) async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       Placemark place = placemarks[0];
//       String address =
//           '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
//       prefs.setString("longitude", position.longitude.toString());
//       prefs.setString("latitude", position.latitude.toString());
//       prefs.setString("address", address);

//       addCurrrentLocation(
//           position.longitude.toString(), position.latitude.toString(), address);
//     } catch (e) {
//       print(e);
//     }
//   });

//   // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
//   // for taking too long in the background.
//   BackgroundFetch.finish(taskId);
// }

// Future<void> addCurrrentLocation(
//     String longitude, String latitude, String address) async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();

//   String userToken = "";

//   userToken = pref.getString("token")!;

//   try {
//     final url = Uri.parse(
//         "https://mmpl.vivekenterprise.org/public/api/addCurrentLocation");
//     Map<String, String> requestBody = <String, String>{
//       'longitude': longitude,
//       'latitude': latitude,
//       'address': address,
//     };
//     // final SharedPreferences token = await userToken;
//     var request = http.MultipartRequest(
//       'POST',
//       url,
//     )..fields.addAll(requestBody);
//     request.headers.addAll({
//       'Content-Type': 'multipart/form-data',
//       'Authorization': 'Bearer $userToken',
//     });
//     var response = await request.send();
//     final respStr = await response.stream.bytesToString();
//     print(
//       jsonDecode(respStr),
//     );
//     print("This is the Status Code$respStr");
//     var encoded = json.decode(respStr);

//     // if (encoded['status'] == true) {
//     //   userToken.setString("token", encoded['token']);
//     //   Navigator.push(
//     //       context, MaterialPageRoute(builder: (ctx) => BottomNavBarScreen()));
//     // } else {
//     //   ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
//     //       content: Text("Please check your username and password")));
//     // }
//     // print(encoded['status']);
//     // print('This is the userId${encoded['data']['user_id']}');
//   } catch (error) {
//     print(error);
//   }
// }

// void _onBackgroundFetchTimeout(String taskId) {
//   print("[BackgroundFetch] TIMEOUT: $taskId");
//   BackgroundFetch.finish(taskId);
// }
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var token;

  getToken() async {
    final SharedPreferences _token = await SharedPreferences.getInstance();
    // print("Toekn : " + _token.getString("token").toString());
    token = await _token.getString("token").toString();
    print("token: " + token);

    // print()
  }

  @override
  void initState() {
    getToken();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: SharedPreferences.getInstance(),
    //     builder:
    //         (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
    //       var x = prefs.data;
    //       if (prefs.hasData) {
    //         if (x!.getString('token') != null) {
    //           return MaterialApp(
    //             theme: ThemeData(
    //                 fontFamily: GoogleFonts.poppins().fontFamily,
    //                 textTheme: TextTheme(titleMedium: GoogleFonts.poppins())),
    //             debugShowCheckedModeBanner: false,
    //             home: BottomNavBarScreen(),
    //           );
    //         } else {
    //           return MaterialApp(
    //             theme: ThemeData(
    //                 fontFamily: GoogleFonts.poppins().fontFamily,
    //                 textTheme: TextTheme(titleMedium: GoogleFonts.poppins())),
    //             debugShowCheckedModeBanner: false,
    //             home: LoginScreen(),
    //           );
    //         }
    //       }

    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         home: CircularProgressIndicator(),
    //       );
    //     });
    return MaterialApp(
      theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: TextTheme(titleMedium: GoogleFonts.poppins())),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
