import 'package:flutter/material.dart';
import 'package:task_master/pages/notifications_page.dart';

class TaskCreationPage extends StatefulWidget {

  @override
  State<TaskCreationPage> createState() {
    return TaskCreationPageState();
  }
}

class TaskCreationPageState extends State<TaskCreationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'TaskCreation Page',
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
            )
          ]

        )
      )
    );
  }

  void voltar(BuildContext context) {
    Navigator.pop(context);
  }

  void proximo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationsPage()),
    );
  }
}