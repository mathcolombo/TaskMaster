import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar datas e horas
import 'package:task_master/models/category.dart';
import 'package:task_master/models/task.dart';
import 'package:task_master/models/enums/task_type.dart'; // Para poder associar uma TaskType
import 'package:task_master/views/widgets/category_chip.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave para o formulário
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Estados para Data e Hora
  DateTime? _startDate;
  TimeOfDay? _startTime;
  DateTime? _endDate;
  TimeOfDay? _endTime;

  // Estado para Categoria selecionada
  Category? _selectedCategory;
  List<Category> _availableCategories = [
    Category(name: 'Exercícios', icon: Icons.directions_bike, color: Colors.pink[100]),
    Category(name: 'Namorada', icon: Icons.favorite, color: Colors.pink[100]),
    Category(name: 'Estudo', icon: Icons.menu_book, color: Colors.pink[100]),
  ];

  // Estado para Prioridade
  int _priority = 0; // 0 para neutro, 1 para alta, -1 para baixa (ou usar um enum)

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Métodos para selecionar Data e Hora
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStart ? (_startTime ?? TimeOfDay.now()) : (_endTime ?? TimeOfDay.now()),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStart) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
    }
  }

  String _formatDateTime(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) {
      return '';
    }
    final DateTime combinedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return DateFormat('d MMM, HH:mm').format(combinedDateTime); // Ex: 1 mai, 15:00
  }

  void _createTask() {
    if (_formKey.currentState!.validate()) {
      // Aqui você coletaria todos os dados e criaria o objeto Task
      // E então passaria de volta para a tela anterior (ou salvaria no banco/API)

      final String title = _titleController.text;
      final String location = _locationController.text;
      final String description = _descriptionController.text;

      // Combinar data e hora de início
      DateTime? fullStartTime;
      if (_startDate != null && _startTime != null) {
        fullStartTime = DateTime(
          _startDate!.year,
          _startDate!.month,
          _startDate!.day,
          _startTime!.hour,
          _startTime!.minute,
        );
      }

      // Combinar data e hora de fim
      DateTime? fullEndTime;
      if (_endDate != null && _endTime != null) {
        fullEndTime = DateTime(
          _endDate!.year,
          _endDate!.month,
          _endDate!.day,
          _endTime!.hour,
          _endTime!.minute,
        );
      }

      // Para fins de exemplo, vamos assumir que a categoria "Exercícios" mapeia para TaskType.gym
      // e outras para TaskType.other. Você pode ter um mapeamento mais sofisticado.
      TaskType taskType = TaskType.other;
      if (_selectedCategory?.name == 'Exercícios') {
        taskType = TaskType.gym;
      } else if (_selectedCategory?.name == 'Estudo') {
        taskType = TaskType.work; // Usando work para estudo
      }
      // Adicionar mais mapeamentos conforme suas categorias

      final newTask = Task(
        title: title,
        description: description,
        location: location,
        time: '${_formatDateTime(_startDate, _startTime)} - ${_formatDateTime(_endDate, _endTime)}',
        type: taskType,
        // priority: _priority, // Se adicionar prioridade ao modelo Task
      );

      debugPrint('Nova tarefa criada: ${newTask.toJson()}');

      // Fechar a tela
      Navigator.pop(context, newTask); // Passa a nova tarefa de volta para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E2E3E), // Fundo escuro como na imagem
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.pop(context); // Fecha a tela sem criar a tarefa
          },
        ),
        title: const Text(
          'Criar tarefa',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome da tarefa
              const Text(
                'Nome da tarefa',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Academia',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da tarefa';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Categoria
              const Text(
                'Categoria',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10.0, // Espaçamento horizontal entre os chips
                runSpacing: 10.0, // Espaçamento vertical entre as linhas de chips
                children: [
                  ..._availableCategories.map((category) => CategoryChip(
                        category: category,
                        isSelected: _selectedCategory?.name == category.name,
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      )).toList(),
                  // Botão para adicionar nova categoria
                  GestureDetector(
                    onTap: () {
                      // Lógica para adicionar nova categoria (ex: abrir um modal)
                      debugPrint('Adicionar nova categoria');
                    },
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2), // Cor do botão '+'
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 24),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Começo e Fim
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Começo',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            await _selectDate(context, true);
                            if (context.mounted) await _selectTime(context, true);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _formatDateTime(_startDate, _startTime).isEmpty
                                      ? '1 maio, 15:00h' // Placeholder
                                      : _formatDateTime(_startDate, _startTime),
                                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Fim',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            await _selectDate(context, false);
                            if (context.mounted) await _selectTime(context, false);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _formatDateTime(_endDate, _endTime).isEmpty
                                      ? '1 maio, 16:30h' // Placeholder
                                      : _formatDateTime(_endDate, _endTime),
                                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Prioridade
              const Text(
                'Prioridade',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _priority = 1; // Prioridade alta
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _priority == 1 ? Colors.pink[300] : Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_upward, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _priority = -1; // Prioridade baixa
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _priority == -1 ? Colors.blue[300] : Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_downward, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Localização
              const Text(
                'Localização',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'SmartFit - Vitória',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Descrição
              const Text(
                'Descrição',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                maxLines: 3, // Permite múltiplas linhas
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Botão Criar tarefa
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _createTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent[400], // Cor do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Criar tarefa',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}