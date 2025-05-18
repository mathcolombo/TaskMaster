import 'package:flutter/material.dart';
import 'package:task_master/pages/taskCreation_page.dart';

class FocusModePage extends StatefulWidget {

  @override
  State<FocusModePage> createState() {
    return FocusModePageState();
  }
}

class FocusModePageState extends State<FocusModePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'FocusMode Page',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: Colors.white
          ),
        )
      ),
      body: Container(
        child:  ElevatedButton(
          onPressed: () {
            voltar(context);
          },
          child: Text('Voltar')
        )
      )
    );
  }

  void voltar(BuildContext context) {
    Navigator.pop(context);
  }
}