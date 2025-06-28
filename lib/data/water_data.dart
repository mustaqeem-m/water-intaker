import 'package:flutter/material.dart';
import 'package:water_intake/models/waterModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Constants/links.dart';
import 'package:water_intake/utils/dateHelper.dart';

class WaterData extends ChangeNotifier {
  List<WaterModel> waterDataList = [];

  // addWater means data to firebase
  void addWater(WaterModel water) async {
    final URL = fireBase_URL;
    var response = await http.post(
      URL,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'amount': double.parse(water.Amount.toString()),
        'unit': 'ml',
        'dateTime': DateTime.now().toIso8601String(),
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

  // getting our data (getWater) from firebase
  Future<List<WaterModel>> getWater() async {
    final URL = fireBase_URL;
    final response = await http.get(URL);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded == null || decoded is! Map<String, dynamic>) {
        return []; // ✅ return empty list if null or not a map
      }

      final extractedData = decoded;
      waterDataList.clear();
      for (var element in extractedData.entries) {
        waterDataList.add(
          WaterModel(
            id: element.key,
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

  String getWeekday(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime getStartOfWeek() {
    DateTime? startOfWeek;
    DateTime dateTime = DateTime.now();

    for (int i = 0; i <= 7; i++) {
      if (getWeekday(dateTime.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = dateTime.subtract(Duration(days: i));
      }
    }

    return startOfWeek ?? DateTime.now();
  }

  String calculateWeeklyWaterIntake(WaterData value) {
    double weeklyWaterIntake = 0;

    //looping through the water data list

    for (var water in value.waterDataList) {
      weeklyWaterIntake += double.parse(water.Amount.toString());
    }

    return weeklyWaterIntake.toStringAsFixed(2);
  }

  //Calculate the daily water intake

  Map<String, double> dailyWaterSummaryCalculator() {
    Map<String, double> dailyWaterSummary = {};
    //looping through water datalist

    for (var water in waterDataList) {
      String date = convertDateTimetoString(water.dateTime);
      double amount = double.parse(water.Amount.toString());

      if (dailyWaterSummary.containsKey(date)) {
        double currentAmount = dailyWaterSummary[date]!;
        currentAmount += amount;
        dailyWaterSummary[date] = currentAmount;
      } else {
        dailyWaterSummary.addAll({date: amount});
      }
    }
    return dailyWaterSummary;
  }
}
