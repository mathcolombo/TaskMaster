import 'package:flutter/material.dart';
import 'package:task_master/pages/calendar_page.dart';
import 'package:task_master/pages/taskCreation_page.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Home Page',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      body: Container(
        child: ElevatedButton(
              onPressed: () {
                proximo(context);
              },
              child: Text('Próximo')
            ),
        )
    );
  }

  void proximo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CalendarPage()),
    );
  }
}