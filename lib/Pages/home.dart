import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 

  final amountController = TextEditingController();
  void addWater() {
    showDialog(context: context,
     builder: (context) => AlertDialog(
      title: Text('Add Water'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Add water to your daily intake'),
          SizedBox(height: 10,),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Amount" ),
          )
        ]
      ),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text('Cancel')),
        TextButton(onPressed: () {
          
        }, child: Text('Save'))
      ],
     )
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true ,
        elevation: 3,
        actions: [
          IconButton(onPressed: ()  {}, icon: Icon(Icons.car_crash_sharp))
        ],
        title: Text("Water"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(onPressed: () {addWater();},child: Icon(Icons.add),),
    );
  }
}
