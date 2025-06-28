import 'package:flutter/material.dart';
import 'package:water_intake/data/water_data.dart';
import 'package:water_intake/models/waterModel.dart';
import '../Constants//Links.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:water_intake/data/water_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController();

  @override
  void initState() {
    Provider.of<WaterData>(context, listen: false).getWater();
    super.initState();
  }

  void saveWater() async {
    Provider.of<WaterData>(context, listen: false).addWater(
      WaterModel(
        Amount: double.parse(amountController.text.toString()),
        dateTime: DateTime.now(),
        unit: 'ml',
      ),
    );

    if (!context.mounted) {
      return;
    }
  }

  void addWater() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Water'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add water to your daily intake'),
            SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(
                signed: false,
                decimal: true,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Amount",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              saveWater();
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 3,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.car_crash_sharp)),
          ],
          title: Text("Water"),
        ),
        body: ListView.builder(
          itemCount: value.waterDataList.length,
          itemBuilder: (context, index) {
            final waterModel = value.waterDataList[index];
            return ListTile(
              title: Text(waterModel.Amount.toString()),
              subtitle: Text(waterModel.id ?? 'No ID'),
            );
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addWater();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
