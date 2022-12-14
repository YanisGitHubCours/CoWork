import 'dart:convert';
import 'dart:io';

import 'package:backoffice_cowork/models/model_schedule.dart';
import 'package:http/http.dart' as http;

import '../models/model_place.dart';
import '../utils/token_preferences.dart';

const getSubscribesUrl = "http://localhost:8081/getSub";
const delSubscribeUrl = "http://localhost:8081/deletePlace";
const createSubscribeUrl = "http://localhost:8081/createSubs";
const updateSubscribeUrl = "http://localhost:8081/updatePlace";

class Subscribes {

  static Future<List<Place>?> getAllSubscribesDesc() async {
    final response = await http.get(
      Uri.parse(getSubscribesUrl),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader:
        TokenSimplePreferences.getToken('token').toString(),
      },
    );
    if (response.statusCode == 400) return null;

    if (response.statusCode != 200) throw Error();

    final jsonBody = json.decode(response.body);

    List<Place> places = [];

    for (int i = 0; i < jsonBody.length; i++) {
      Place ptmp = Place(
        jsonBody[i]["place"]["name"],
        jsonBody[i]["place"]["city"],
        jsonBody[i]["place"]["cp"],
        jsonBody[i]["place"]["_id"],
      );
      for (int j = 0; j < jsonBody[i]["schedules"].length; j++) {
        Schedule stmp = Schedule(
          jsonBody[i]["schedules"][j]["idPlace"],
          jsonBody[i]["schedules"][j]["day"],
          jsonBody[i]["schedules"][j]["time"],
          jsonBody[i]["schedules"][j]["_id"],
        );
        ptmp.schedules.add(stmp);
      }
      places.add(ptmp);
    }
    return places;
  }

  static Future countSubscribes() async {
    final response = await http.get(
      Uri.parse(getPlacesUrl),
      headers: {
        HttpHeaders.authorizationHeader:
        TokenSimplePreferences.getToken('token').toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    final counter = jsonBody.length;

    return counter;
  }

  static Future<bool> delPlace(String id) async {
    var body = jsonEncode({"id": id});
    final response = await http.delete(
      Uri.parse(delPlaceUrl),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader:
        TokenSimplePreferences.getToken('token').toString(),
      },
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );

    if (response.statusCode != 200) {
      throw Error();
    }

    return true;
  }
}
