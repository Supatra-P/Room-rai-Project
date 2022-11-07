import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomrai1/controllers/task_controller.dart';
import 'package:roomrai1/models/Transaction.dart';
import 'package:roomrai1/models/task.dart';
import 'package:roomrai1/provider/favorite_provider.dart';
import 'package:roomrai1/screens/demoMap.dart';
import 'package:roomrai1/screens/home.dart';
import 'package:roomrai1/screens/search_historys.dart';

import '../provider/transaction_provider.dart';

//class searchbar
class MySearchDelegate extends SearchDelegate {
  final TaskController _taskController = Get.put(TaskController());
  String _showSearch = ""; //EGR710/Faculity of Engineering
  String _codeRoom = ""; //EGR710
  int _floor = 0; //7
  int _room = 0; //10
  String _building = ""; //Faculity of Engineering
  dynamic detail;

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => {_taskController.getTasks(), close(context, null)},
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Color.fromRGBO(243, 166, 182, 1),
      ));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistorySearch()),
              );
              _taskController.getTasks();
            },
            icon: const Icon(Icons.history,
                color: Color.fromRGBO(243, 166, 182, 1))),
        IconButton(
            onPressed: () {
              _taskController.getTasks();
              if (query.isEmpty) {
                // close(context, null);
              } else {
                query = '';
              }
            },
            icon: (query.isEmpty)
                ? Icon(
                    Icons.search,
                    color: Color.fromRGBO(243, 166, 182, 1),
                  )
                : Icon(Icons.clear, color: Color.fromRGBO(243, 166, 182, 1))),
        SizedBox(
          width: 16,
        )
      ];

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: demoMap(
        codeRoom: _codeRoom,
        floor: _floor,
        room: _room,
        building: _building,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final providerFav = FavoriteProvider.of(context);

    //search
    List<Transaction> providerRoom =
        TransactionProvider().transactions.where((data) {
      final result = data.showSearch.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: providerRoom.length,
      itemBuilder: (context, index) {
        final data = providerRoom[index];

        return ListTile(
          title: Text(
            data.codeRoom,
            style: TextStyle(
                color: Color.fromRGBO(243, 166, 182, 1),
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(data.building),
          onTap: () {
            _showSearch = data.showSearch;
            _codeRoom = data.codeRoom;
            _floor = data.floor;
            _room = data.room;
            _building = data.building;
            detail = data;
            _addTaskToDb();
            showResults(context);
            _taskController.getTasks();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => demoMap(
                  codeRoom: _codeRoom,
                  floor: _floor,
                  room: _room,
                  building: _building,
                ),
              ),
            );
          },
          trailing: IconButton(
            onPressed: () {
              providerFav.toggleFavorite(data);
            },
            icon: providerFav.isExist(data)
                ? const Icon(Icons.favorite,
                    color: Color.fromRGBO(243, 166, 182, 1))
                : const Icon(Icons.favorite_border),
          ),
        );
      },
    );
  }

  _addTaskToDb() async {
    print("TTASK: ${_codeRoom} ${_floor} ${_room} ${_building} ${_showSearch}");
    int value = await _taskController.addTask(
        task: Task(
      codeRoom: _codeRoom,
      floor: _floor,
      room: _room,
      building: _building,
      showSearch: _showSearch,
    ));
    print("My id is" + " $value");
  }
}
