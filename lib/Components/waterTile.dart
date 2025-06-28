import 'package:flutter/material.dart';
import 'package:water_intake/data/water_data.dart';
import 'package:water_intake/models/waterModel.dart';
import 'package:provider/provider.dart';

class WaterTile extends StatelessWidget {
  const WaterTile({super.key, required this.waterModel});

  final WaterModel waterModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: IconButton(
          onPressed: () {
            Provider.of<WaterData>(
              context,
              listen: false,
            ).deleteWater(waterModel);
          },
          icon: Icon(Icons.delete),
        ),
        title: Row(
          children: [
            const Icon(Icons.water_drop, size: 20, color: Colors.lightBlue),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                waterModel.Amount.toStringAsFixed(2),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Text(
            "${waterModel.dateTime.month}/${waterModel.dateTime.day}",
          ),
        ),
      ),
    );
  }
}
