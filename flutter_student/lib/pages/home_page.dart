import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/students.dart';
import 'add_student_page.dart';
import 'detail_student_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Students>(context).initializeData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allStudentProvider = Provider.of<Students>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ALL STUDENT"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddStudent()),
              );
            },
          ),
        ],
      ),
      body: allStudentProvider.allStudent.isEmpty
          ? SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No Data",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AddStudent()),
                      );
                    },
                    child: const Text(
                      "Add Student",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: allStudentProvider.allStudent.length,
              itemBuilder: (context, index) {
                var id = allStudentProvider.allStudent[index].id;
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailStudent.routeName,
                      arguments: id,
                    );
                  },
                  title: Text(
                    allStudentProvider.allStudent[index].name,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      allStudentProvider.deletePlayer(id, context);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
