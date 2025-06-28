import 'package:water_intake/bars/IndividualBar.dart';

class BarData {
  final double sunWaterAmt;
  final double monWaterAmt;
  final double tueWaterAmt;
  final double wedWaterAmt;
  final double thuWaterAmt;
  final double friWaterAmt;
  final double satWaterAmt;

  BarData({
    required this.sunWaterAmt,
    required this.monWaterAmt,
    required this.tueWaterAmt,
    required this.wedWaterAmt,
    required this.thuWaterAmt,
    required this.friWaterAmt,
    required this.satWaterAmt,
  });

  List<Individualbar> barData = [];

  // here we initialize the bar data
  void initBar() {
    barData = [
      Individualbar(x: 0, y: sunWaterAmt),
      Individualbar(x: 1, y: monWaterAmt),
      Individualbar(x: 2, y: tueWaterAmt),
      Individualbar(x: 3, y: wedWaterAmt),
      Individualbar(x: 4, y: thuWaterAmt),
      Individualbar(x: 5, y: friWaterAmt),
      Individualbar(x: 6, y: satWaterAmt),
    ];
  }
}
