// class HttpServices {
//   Future<List<ChannelListModel>> getChannelList() async {
//     var url = base.BaseURL.channelListUrl;
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       return List<ChannelListModel>.fromJson(jsonDecode(response.body)); //I have problem in this line
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load album');
//     }
//   }
// }