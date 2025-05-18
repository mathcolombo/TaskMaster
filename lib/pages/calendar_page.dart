import 'package:flutter/material.dart';
import 'package:task_master/pages/taskCreation_page.dart';

class CalendarPage extends StatefulWidget {

  @override
  State<CalendarPage> createState() {
    return CalendarPageState();
  }
}

class CalendarPageState extends State<CalendarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Calendar Page',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                voltar(context);
              },
              child: Text('Voltar')
            ),
            ElevatedButton(
              onPressed: () {
                proximo(context);
              },
              child: Text('Próximo')
            ),
          ]
        )
      ),
    );
  }

  void voltar(BuildContext context) {
    Navigator.pop(context);
  }

  void proximo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskCreationPage()),
    );
  }
}