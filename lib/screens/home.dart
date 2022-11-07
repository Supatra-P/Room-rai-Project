import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:roomrai1/controllers/task_controller.dart';
import 'package:roomrai1/models/Transaction.dart';
import 'package:roomrai1/models/task.dart';
import 'package:roomrai1/provider/favorite_provider.dart';
import 'package:roomrai1/screens/MySearchDelegate.dart';
import 'package:roomrai1/screens/demoMap.dart';
import 'package:roomrai1/screens/favorite.dart';
import 'package:roomrai1/screens/room.dart';
import 'package:roomrai1/screens/search_historys.dart';

import '../provider/transaction_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    _taskController.getTasks();
    final providerFav = FavoriteProvider.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   // leading: IconButton(
      //   //     onPressed: () {
      //   //       final route = MaterialPageRoute(
      //   //         builder: (context) => const FavoritePage(),
      //   //       );
      //   //       Navigator.push(context, route);
      //   //     },
      //   //     icon: const Icon(Icons.favorite_border)),
      //   // // title: Text('Roomrai'),
      //   // actions: [
      //   //   IconButton(
      //   //       onPressed: () {
      //   //         showSearch(context: context, delegate: MySearchDelegate());
      //   //       },
      //   //       icon: const Icon(Icons.search)),
      //   // ],
      //   automaticallyImplyLeading: false,
      //   titleSpacing: 8,
      //   title: Row(children: [
      //     // favorite icon
      //     Container(
      //         width: 45,
      //         decoration: BoxDecoration(
      //           color: Color.fromRGBO(243, 166, 182, 1),
      //           shape: BoxShape.circle,
      //         ),
      //         child: IconButton(
      //           onPressed: () {
      //             final route = MaterialPageRoute(
      //               builder: (context) => const FavoritePage(),
      //             );
      //             Navigator.push(context, route);
      //           },
      //           icon: const Icon(Icons.favorite_border,
      //               color: Color.fromARGB(255, 255, 255, 255)),
      //           iconSize: 28,
      //         )),
          
      //     Container(
      //       padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/4,),
      //       child: Text(
      //         "Room-Rai",
      //         style: TextStyle(
      //           color: Color.fromRGBO(243, 166, 182, 1),
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ),
      //     // search bar
      //     // Expanded(
      //     //   child: Column(
      //     //     children: [
      //     //       TextField(
      //     //         style: const TextStyle(color: Colors.black),
      //     //         decoration: InputDecoration(
      //     //           fillColor: Colors.white,
      //     //           filled: true,
      //     //           hintText: "Search maps",
      //     //           hintStyle: const TextStyle(color: Colors.black54),
      //     //           contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      //     //           floatingLabelBehavior: FloatingLabelBehavior.never,
      //     //           enabledBorder: OutlineInputBorder(
      //     //             borderRadius: BorderRadius.circular(28),
      //     //             borderSide: const BorderSide(color: Colors.black26, width: 2.5),
      //     //           ),
      //     //           focusedBorder: OutlineInputBorder(
      //     //             borderRadius: BorderRadius.circular(28),
      //     //             borderSide:
      //     //                 const BorderSide(color: Color.fromRGBO(243, 166, 182, 1), width: 2.5),
      //     //           ),
      //     //           suffixIcon: IconButton(
      //     //             icon: const Icon(Icons.search, size: 28,),
      //     //             color: const Color.fromRGBO(243, 166, 182, 1),
      //     //             onPressed: () {
      //     //               showSearch(context: context, delegate: MySearchDelegate());
      //     //             },
      //     //           ),
      //     //         ),
      //     //       ),
      //     //     ],
      //     //   ),
      //     // ),
      //   ]),
      //   actions: [
      //     Container(
      //       width: 45,
      //       margin: EdgeInsets.only(
      //         right: 16,
      //       ),
      //       decoration: BoxDecoration(
      //         color: Color.fromRGBO(243, 166, 182, 1),
      //         shape: BoxShape.circle,
      //       ),
      //       child: IconButton(
      //         icon: const Icon(
      //           Icons.search,
      //           size: 28,
      //         ),
      //         color: Colors.white,
      //         onPressed: () {
      //           showSearch(context: context, delegate: MySearchDelegate());
      //         },
      //       ),
      //     ),
      //   ],

      //   elevation: 0,
      //   backgroundColor: Colors.white.withOpacity(0),
      // ),

      // body: const MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   home: demoMap(),
      // ),
      // floatingActionButton: Row(
      //   children: [
      //     SizedBox(width: 21,),
      //     Container(
      //       width: 56,
      //       padding: const EdgeInsets.only(top: 24, left: 12),
      //       alignment: Alignment.centerLeft,
      //       child: Column(
      //         children: [
      //           SizedBox(height: 150,),
      //           // compass
      //           FloatingActionButton(
      //             heroTag: "compassbtn",
      //             onPressed: () {},
      //             backgroundColor: Colors.white,
      //             child: const Icon(
      //               Icons.rocket_outlined,
      //               size: 28,
      //               color: Color.fromRGBO(243, 166, 182, 1),
      //             ),
      //           ),
      //           SizedBox(height: 4,),
      //           // current locaction
      //           FloatingActionButton(
      //             heroTag: "locabtn",
      //             onPressed: () {},
      //             backgroundColor: Colors.white,
      //             child: const Icon(
      //               Icons.location_on_outlined,
      //               size: 28,
      //               color: Color.fromRGBO(243, 166, 182, 1),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}