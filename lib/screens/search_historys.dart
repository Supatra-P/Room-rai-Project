import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:roomrai1/models/Transaction.dart';
import 'package:roomrai1/provider/favorite_provider.dart';
import 'package:roomrai1/screens/MySearchDelegate.dart';
import 'package:roomrai1/screens/demoMap.dart';
import 'package:roomrai1/screens/favorite.dart';
import 'package:roomrai1/screens/home.dart';
import 'package:roomrai1/screens/room.dart';

import '../controllers/task_controller.dart';
import '../provider/transaction_provider.dart';

class HistorySearch extends StatefulWidget {
  const HistorySearch({Key? key}) : super(key: key);
  @override
  State<HistorySearch> createState() => _HistorySearchState();
}

class _HistorySearchState extends State<HistorySearch> {
  final TaskController _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    final List<Transaction> providerRoom = TransactionProvider().transactions;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromRGBO(243, 166, 182, 1),
            )),
        title: Text(
          "History",
          style: TextStyle(
            color: Color.fromRGBO(243, 166, 182, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(child: Obx(() {
            return ListView.builder(
              itemCount: _taskController.taskListHistory.length,
              itemBuilder: (context, index) {
                final data = _taskController.taskListHistory[index];
                return ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.history,
                          color: Color.fromRGBO(243, 166, 182, 1)),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        data.codeRoom!,
                        style: TextStyle(
                            color: Color.fromRGBO(243, 166, 182, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      SizedBox(
                        width: 32,
                      ),
                      Text(data.building!),
                    ],
                  ),
                  onTap: () {
                    final route = MaterialPageRoute(
                      builder: (context) => demoMap(
                        codeRoom: data.codeRoom!,
                        floor: data.floor!,
                        room: data.room!,
                        building: data.building!,
                      ),
                    );
                    Navigator.push(context, route);
                  },
                  trailing: IconButton(
                      onPressed: () {
                        _taskController.delete(data);
                        print(_taskController.taskListHistory.length);
                        _taskController.getTasks();
                      },
                      icon: Icon(Icons.close_rounded,
                          color: Color.fromARGB(255, 237, 103, 94))),
                );
              },
            );
          }))
        ],
      ),
    );
  }
}
