import 'package:flutter/material.dart';
import 'package:water_intake/models/waterModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Constants/links.dart';

class WaterData extends ChangeNotifier {
  List<WaterModel> waterDataList = [];

  //addwater means data to firebase

  void addWater(WaterModel water) async {
    final URL = fireBase_URL;
    var response = await http.post(
      URL,
      headers: {
        'Content-Type': 'application/json',
      }, // saying tyoe of our data is json
      body: json.encode({
        'amount': double.parse(water.Amount.toString()),
        'unit': 'ml',
        'DateTime': DateTime.now().toString(),
      }),
    );

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      waterDataList.add(
        WaterModel(
          id: extractedData['name'],
          Amount: water.Amount,
          dateTime: water.dateTime,
          unit: 'ml',
        ),
      );
    } else {
      print("Error ${response.statusCode}");
    }
    notifyListeners();
  }

  // getting our data (getwater) from firebase
  Future<List<WaterModel>> getWater() async {
    final URL = fireBase_URL;

    final response = await http.get(URL);

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      for (var element in extractedData.entries) {
        waterDataList.add(
          WaterModel(
            id: element.key, // ✅ This line adds the Firebase key as ID
            Amount: (element.value['amount'] ?? 0).toDouble(),
            dateTime: element.value['dateTime'] != null
                ? DateTime.parse(element.value['dateTime'])
                : DateTime.now(),
            unit: element.value['unit'] ?? 'ml',
          ),
        );
      }
    }
    notifyListeners();
    return waterDataList;
  }

  void deleteWater(WaterModel waterModel) {
    final URL = Uri.https(
      'water-intaker-c256f-default-rtdb.firebaseio.com',
      'water/${waterModel.id}.json',
    );

    http.delete(URL);

    waterDataList.removeWhere((element) => element.id == waterModel.id);
    notifyListeners();
  }
}
