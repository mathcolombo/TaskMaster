import 'package:flutter/material.dart';
import 'package:task_master/pages/focusMode_page.dart';
import 'package:task_master/pages/taskCreation_page.dart';

class NotificationsPage extends StatefulWidget {

  @override
  State<NotificationsPage> createState() {
    return NotificationsPageState();
  }
}

class NotificationsPageState extends State<NotificationsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Notifications Page',
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
      MaterialPageRoute(builder: (context) => FocusModePage()),
    );
  }
}