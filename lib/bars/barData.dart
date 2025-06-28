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
      Individualbar(x: 0, y: monWaterAmt),
      Individualbar(x: 0, y: tueWaterAmt),
      Individualbar(x: 0, y: wedWaterAmt),
      Individualbar(x: 0, y: thuWaterAmt),
      Individualbar(x: 0, y: friWaterAmt),
      Individualbar(x: 0, y: satWaterAmt),
    ];
  }
}
