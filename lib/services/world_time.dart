import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name for the UI
  late String time; //the time in that location
  late String flag; // URL to an asset flag icon
  late String url; //location in url for api endpoint
  late bool isDaytime; //to check day or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    Future.delayed(Duration(seconds: 5), () {});

    try {
      var res = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      var response = await http.get(res);
      Map data = jsonDecode(response.body); // this requires import dart:convert

      String datetime = data['datetime'];
      DateTime now = DateTime.parse(datetime.substring(0, 19));
      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      this.time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught Error: $e');
      time = 'Could not get time data';
    }
  }
}
