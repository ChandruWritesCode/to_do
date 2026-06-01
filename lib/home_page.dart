import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("To Do"),
        elevation: 200,
        actions: [
          IconButton(
            onPressed: () {
              final pr = context.read<TasksProvider>();
              for (int i = pr.checkList.length - 1; i >= 0; i--) {
                if (pr.checkList[i]) {
                  pr.removeTask(i);
                }
              }
            },
            icon: const Icon(Icons.sync),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Task"),
                  content: TextField(
                    autofocus: true,
                    controller: _cont,
                    decoration: const InputDecoration(hint: Text("your task")),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.read<TasksProvider>().addTask(_cont.text);
                        Navigator.of(context).pop();
                        _cont.clear(); // setState
                      },
                      child: const Text("add"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _cont.clear();
                      },
                      child: const Text("cancel"),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add, size: 40),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: context.watch<TasksProvider>().tasks.length,
          itemBuilder: (context, idx) {
            return TaskCard(idx);
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskCard extends StatefulWidget {
  int idx;
  TaskCard(this.idx, {super.key});
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    // return Container(color: Colors.black, child: Text("Hello"));
    return Card(
      color: Theme.of(context).canvasColor,
      elevation: 20,
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Checkbox(
              value: context.read<TasksProvider>().checkList[widget.idx],
              onChanged: (val) {
                setState(() {
                  context.read<TasksProvider>().checkList[widget.idx] = !context
                      .read<TasksProvider>()
                      .checkList[widget.idx];
                });
              },
            ),
            Text(
              context.read<TasksProvider>().tasks[widget.idx],
              style: TextStyle(
                fontSize: 20,
                decorationThickness: 2,
                decoration: context.read<TasksProvider>().checkList[widget.idx]
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
