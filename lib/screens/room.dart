import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:roomrai1/models/Transaction.dart';
import 'package:roomrai1/provider/favorite_provider.dart';
import 'package:roomrai1/screens/favorite.dart';
import 'package:roomrai1/screens/home.dart';

import '../provider/transaction_provider.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key, required this.data}) : super(key: key);
  final data;
  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    final List<Transaction> providerRoom = TransactionProvider().transactions;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromRGBO(243, 166, 182, 1),
            ),
          ),
          title: Text(
            widget.data.showSearch,
            style: TextStyle(
              color: Color.fromRGBO(243, 166, 182, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("building: ${widget.data.building}"),
              Text("code room: ${widget.data.codeRoom}"),
              Text("floor: ${widget.data.floor}  room: ${widget.data.room}"),
            ],
          ),
        ));
  }
}
