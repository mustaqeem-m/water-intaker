class WaterModel {
  final String? id;
  final double Amount;
  final DateTime dateTime;

  WaterModel({
    this.id,
    required this.Amount,
    required this.dateTime,
    required String unit,
  });

  factory WaterModel.fromJson(Map<String, dynamic> json, String id) {
    return WaterModel(
      id: id,
      Amount: json['amount'],
      dateTime: DateTime.parse(json['dateTime']),
      unit: json['unit'],
    );
  }

  //! here we convert water model to json to send it to Firebase
  Map<String, dynamic> toJson() {
    return {'amount': Amount, 'dateTime': DateTime.now()};
  }
}
