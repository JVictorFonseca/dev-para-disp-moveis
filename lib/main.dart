import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskListScreen(),
    );
  }
}

class Task {
  String title;
  String description;
  String status;
  DateTime dueDate;
  String category;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
    required this.category,
    this.isCompleted = false,
  });
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void _addTask() {
    setState(() {
      tasks.add(Task(
        title: titleController.text,
        description: descController.text,
        status: 'Pendente',
        dueDate: selectedDate,
        category: categoryController.text,
      ));
    });
    titleController.clear();
    descController.clear();
    categoryController.clear();
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciador de Tarefas')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Título')),
                TextField(
                    controller: descController,
                    decoration: InputDecoration(labelText: 'Descrição')),
                TextField(
                    controller: categoryController,
                    decoration: InputDecoration(labelText: 'Categoria')),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: _addTask, child: Text('Adicionar Tarefa')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title,
                      style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null)),
                  subtitle: Text('${task.description} - ${task.category}'),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) => _toggleTaskCompletion(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
