import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:task_master/views/task_schedule_screen.dart'; // Aponta para a tela de tarefas

void main() async { // Garanta que 'async' está aqui
  WidgetsFlutterBinding.ensureInitialized(); // Garanta que esta linha está aqui
  await initializeDateFormatting('pt_BR', null); // Garanta que 'await' está aqui
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Master',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TaskScheduleScreen(),
    );
  }
}