import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roomrai1/screens/demoMap.dart';
import 'package:roomrai1/screens/home.dart';

class startPage extends StatelessWidget {
  const startPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Button"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 1,),
            Text("Maps Navigator"),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
              child: Text(
                "ROOM-RAI",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset('assets/images/logo.png'),
            Spacer(flex: 3,),
            Container(
             width: 160,
             height: 50,
              child: TextButton(
                child: Text(
                  "Get Started",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(243, 166, 182, 1),
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28))))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const demoMap()));
                },
              ),
            ),
            Spacer(flex: 2,),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
