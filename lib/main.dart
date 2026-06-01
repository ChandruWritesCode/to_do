import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home_page.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TasksProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.amber,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class TasksProvider extends ChangeNotifier {
  List<String> tasks = [];
  List<bool> checkList = [];

  void addTask(String task) {
    tasks.add(task);
    checkList.add(false);
    notifyListeners();
  }

  void toggleTask(int idx) {
    checkList[idx] = !checkList[idx];
    notifyListeners();
  }

  void removeTask(int idx) {
    tasks.removeAt(idx);
    checkList.removeAt(idx);
    notifyListeners();
  }
}
