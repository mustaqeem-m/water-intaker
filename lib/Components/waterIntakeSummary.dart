import 'package:flutter/material.dart';
import 'package:water_intake/bars/barGraph.dart';
import 'package:water_intake/data/water_data.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/utils/dateHelper.dart';

class Waterintakesummary extends StatelessWidget {
  final DateTime startofWeek;

  const Waterintakesummary({super.key, required this.startofWeek});
  double maxAmountCalculator(
    WaterData waterData,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? maxAmount = 100;

    List<double> values = [
      waterData.dailyWaterSummaryCalculator()[sunday] ?? 0,
      waterData.dailyWaterSummaryCalculator()[monday] ?? 0,
      waterData.dailyWaterSummaryCalculator()[tuesday] ?? 0,
      waterData.dailyWaterSummaryCalculator()[wednesday] ?? 0,
      waterData.dailyWaterSummaryCalculator()[thursday] ?? 0,
      waterData.dailyWaterSummaryCalculator()[friday] ?? 0,
      waterData.dailyWaterSummaryCalculator()[saturday] ?? 0,
    ];
    // in above list we r gonna sort from smallest to largest
    //and thn we are gonna inc the max amount by x% of the largest val
    maxAmount = values.last * 1.3;

    return maxAmount == 0 ? 100 : maxAmount;
  }

  @override
  Widget build(BuildContext context) {
    String sunday = convertDateTimetoString(startofWeek.add(Duration(days: 0)));
    String monday = convertDateTimetoString(startofWeek.add(Duration(days: 1)));
    String tuesday = convertDateTimetoString(
      startofWeek.add(Duration(days: 2)),
    );
    String wednesday = convertDateTimetoString(
      startofWeek.add(Duration(days: 3)),
    );
    String thursday = convertDateTimetoString(
      startofWeek.add(Duration(days: 4)),
    );
    String friday = convertDateTimetoString(startofWeek.add(Duration(days: 5)));
    String saturday = convertDateTimetoString(
      startofWeek.add(Duration(days: 6)),
    );
    return Consumer<WaterData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: BarGraph(
          maxY: maxAmountCalculator(
            value,
            sunday,
            monday,
            tuesday,
            wednesday,
            thursday,
            friday,
            saturday,
          ),
          sunWaterAmt: value.dailyWaterSummaryCalculator()[sunday] ?? 0,
          monWaterAmt: value.dailyWaterSummaryCalculator()[monday] ?? 0,
          tueWaterAmt: value.dailyWaterSummaryCalculator()[tuesday] ?? 0,
          wedWaterAmt: value.dailyWaterSummaryCalculator()[wednesday] ?? 0,
          thuWaterAmt: value.dailyWaterSummaryCalculator()[thursday] ?? 0,
          friWaterAmt: value.dailyWaterSummaryCalculator()[friday] ?? 0,
          satWaterAmt: value.dailyWaterSummaryCalculator()[saturday] ?? 0,
        ),
      ),
    );
  }
}
