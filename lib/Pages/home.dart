import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      floatingActionButton: FloatingActionButton(onPressed: () {},child: Icon(Icons.add),),
    );
  }
}
