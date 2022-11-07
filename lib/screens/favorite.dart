import 'package:flutter/material.dart';
import 'package:roomrai1/provider/favorite_provider.dart';
import 'package:roomrai1/screens/MySearchDelegate.dart';
import 'package:roomrai1/screens/demoMap.dart';
import 'package:roomrai1/screens/home.dart';
import 'package:roomrai1/screens/room.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String _showSearch = ""; //EGR710/Faculity of Engineering
  String _codeRoom = ""; //EGR710
  int _floor = 0; //7
  int _room = 0; //10
  String _building = ""; //Faculity of Engineering

  @override
  Widget build(BuildContext context) {
    final providerFav = FavoriteProvider.of(context);
    final providerRoom = providerFav.data;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 8,
        title: Row(children: [
          // favorite icon
          Container(
              width: 45,
              decoration: BoxDecoration(
                color: Color.fromRGBO(243, 166, 182, 1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  final route = MaterialPageRoute(
                    builder: (context) => const demoMap(),
                  );
                  Navigator.push(context, route);
                },
                icon: const Icon(Icons.favorite,
                    color: Color.fromARGB(255, 255, 255, 255)),
                iconSize: 26,
              )),
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 4,
            ),
            child: Text(
              "Favorites",
              style: TextStyle(
                color: Color.fromRGBO(243, 166, 182, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
        actions: [
          Container(
            width: 45,
            margin: EdgeInsets.only(
              right: 16,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(243, 166, 182, 1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 28,
              ),
              color: Colors.white,
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
      ),
      body: ListView.builder(
        itemCount: providerRoom.length,
        itemBuilder: (context, index) {
          final data = providerRoom[index];
          _showSearch = data.showSearch;
          _codeRoom = data.codeRoom;
          _floor = data.floor;
          _room = data.room;
          _building = data.building;

          return ListTile(
            title: Text(
              data.codeRoom,
              style: TextStyle(
                  color: Color.fromRGBO(243, 166, 182, 1),
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(data.building),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => demoMap(
                    codeRoom: _codeRoom,
                    floor: _floor,
                    room: _room,
                    building: _building,
                  ),
                  // MyHomePage(),
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
      ),
    );
  }
}
