import 'package:flutter/material.dart';
import 'package:water_intake/Components/waterTile.dart';
import 'package:water_intake/Pages/aboutScreen.dart';
import 'package:water_intake/Pages/settingsScreen.dart';
import 'package:water_intake/data/water_data.dart';
import 'package:water_intake/models/waterModel.dart';
import '../Constants//Links.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:water_intake/Components/waterIntakeSummary.dart';
import 'package:water_intake/Pages/AboutScreen.dart' hide Aboutscreen;
import 'package:water_intake/Pages/SettingsScreen.dart' hide SettingsScreen;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController();

  bool _isLoading = true;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    await Provider.of<WaterData>(context, listen: false).getWater().then((
      waters,
    ) {
      setState(() {
        _isLoading = false;
      });
    });
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

    amountController.clear();
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Weekly: ',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value.calculateWeeklyWaterIntake(value),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: RefreshProgressIndicator())
            : value.waterDataList.isEmpty
            ? const Center(child: Text("No water data yet!"))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Waterintakesummary(startofWeek: value.getStartOfWeek()),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: value.waterDataList.length,
                      itemBuilder: (context, index) {
                        final waterModel = value.waterDataList[index];
                        return WaterTile(waterModel: waterModel);
                      },
                    ),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: addWater,
          child: Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "Water Intaker",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
                title: Text('Settings'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Aboutscreen()),
                  );
                },
                title: Text("About"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
