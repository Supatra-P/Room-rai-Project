import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:roomrai1/components/constants.dart';
import 'package:roomrai1/screens/MySearchDelegate.dart';
import 'package:roomrai1/screens/favorite.dart';
import 'package:roomrai1/screens/home.dart';

import '../controllers/task_controller.dart';
import '../provider/favorite_provider.dart';

class demoMap extends StatefulWidget {
  const demoMap({Key? key, this.detail}) : super(key: key);
  final detail;

  @override
  State<demoMap> createState() => _demoMapState();
}

class _demoMapState extends State<demoMap> with SingleTickerProviderStateMixin {
  final TaskController _taskController = Get.put(TaskController());

  late final GoogleMapController _googleMapController;
  static const LatLng _defaultLocation =
      LatLng(14.071341572315816, 100.61675356455655);
  static const LatLng engineerBuilding =
      LatLng(14.068894918174884, 100.60599664695536);
  static const LatLng scBuilding = LatLng(14.069248, 100.603473);

  static const markEGR = Marker(
    markerId: MarkerId('EGR Location'),
    position: engineerBuilding,
    infoWindow:
        InfoWindow(title: 'Faculity of Engineering', snippet: 'codeRoom'),
  );

  static const markSC = Marker(
    markerId: MarkerId('SC Location'),
    position: scBuilding,
    infoWindow: InfoWindow(
        title: 'Social Sciences Building Complex or SC buildings',
        snippet: 'codeRoom'),
  );
  //Set maker
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('My Default Location'),
      position: _defaultLocation,
      infoWindow: InfoWindow(title: 'Location', snippet: 'u still here'),
    ),
  };

  //List Polyline
  final List<LatLng> polylineCoordinates = [];

  MapType _currentMapType = MapType.normal;

  //map style
  void _changeMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  //go back to location still
  Future<void> _goToDefaultLocation() async {
    const _defaultPosition = _defaultLocation;

    _googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(_defaultPosition, 15));
    setState(() {});
  }

  getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    if ("Faculity of Engineering" == widget.detail) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          google_api_key,
          PointLatLng(_defaultLocation.latitude, _defaultLocation.longitude),
          PointLatLng(engineerBuilding.latitude, engineerBuilding.longitude));
      if (result.points.isNotEmpty) {
        polylineCoordinates.clear();
        result.points.forEach((PointLatLng point) => polylineCoordinates.add(
              LatLng(point.latitude, point.longitude),
            ));
      }
    }
    if ("Social Sciences Building Complex or SC buildings" == widget.detail) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          google_api_key,
          PointLatLng(_defaultLocation.latitude, _defaultLocation.longitude),
          PointLatLng(scBuilding.latitude, scBuilding.longitude));
      if (result.points.isNotEmpty) {
        polylineCoordinates.clear();
        result.points.forEach((PointLatLng point) => polylineCoordinates.add(
              LatLng(point.latitude, point.longitude),
            ));
      }
    }
    setState(() {});
  }

  checkBuildingLocation() {
    if ("Faculity of Engineering" == widget.detail) {
      _markers.add(markEGR);
    }
    if ("Social Sciences Building Complex or SC buildings" == widget.detail) {
      _markers.add(markSC);
    }
  }

  // _showRoomDirection
  late TransformationController controller;
  TapDownDetails? tapDownDetails;

  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..addListener(() {
        controller.value = animation!.value;
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    animationController.dispose();

    super.dispose();
  }

  void _showRoomDirection(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "EGR302",
                  style: TextStyle(
                      color: Color.fromRGBO(243, 166, 182, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Faculty of Engineering",
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "3",
                          style: TextStyle(
                              color: Color.fromRGBO(243, 166, 182, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Floor",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "2",
                          style: TextStyle(
                              color: Color.fromRGBO(243, 166, 182, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Room",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onDoubleTapDown: (details) => tapDownDetails = details,
                  onDoubleTap: () {
                    final position = tapDownDetails!.localPosition;

                    final double scale = 3;
                    final x = -position.dx * (scale - 1);
                    final y = -position.dy * (scale - 1);
                    final zoomed = Matrix4.identity()
                      ..translate(x, y)
                      ..scale(scale);

                    final end = controller.value.isIdentity()
                        ? zoomed
                        : Matrix4.identity();

                    animation = Matrix4Tween(
                      begin: controller.value,
                      end: end,
                    ).animate(CurveTween(curve: Curves.easeOut)
                        .animate(animationController));

                    animationController.forward(from: 0);
                  },
                  child: InteractiveViewer(
                    clipBehavior: Clip.none,
                    transformationController: controller,
                    panEnabled: false,
                    scaleEnabled: false,
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.asset(
                          'assets/images/SCf300ppi-03.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _taskController.getTasks();
    final providerFav = FavoriteProvider.of(context);

    checkBuildingLocation();
    print("name building: ${widget.detail}");
    print("mark count: ${_markers.length}");

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
                    builder: (context) => const FavoritePage(),
                  );
                  Navigator.push(context, route);
                },
                icon: const Icon(Icons.favorite_border,
                    color: Color.fromARGB(255, 255, 255, 255)),
                iconSize: 28,
              )),

          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 4,
            ),
            child: Text(
              "Room-Rai",
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
      body: Stack(children: [
        GoogleMap(
          onMapCreated: ((controller) => _googleMapController = controller),
          initialCameraPosition:
              CameraPosition(target: _defaultLocation, zoom: 15),
          mapType: _currentMapType,
          markers: _markers,
          polylines: {
            Polyline(
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
              color: primaryColor,
              width: 6,
            )
          },
        ),
        Container(
          padding: const EdgeInsets.only(top: 24),
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              // FloatingActionButton(
              //   heroTag: "btn1",
              //   onPressed: _changeMapType,
              //   backgroundColor: Colors.green,
              //   child: const Icon(
              //     Icons.map,
              //     size: 30,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // FloatingActionButton(
              //   heroTag: "btn2",
              //   onPressed: _goToDefaultLocation,
              //   backgroundColor: Colors.red,
              //   child: const Icon(
              //     Icons.home_rounded,
              //     size: 36,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 1.4),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromRGBO(243, 166, 182, 1),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    // backgroundColor: Color.fromRGBO(243, 166, 182, 0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 2),
                  ),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: getPolyPoints,
                ),
              ),
            ],
          ),
        )
      ]),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 56,
            margin: EdgeInsets.only(left: 21),
            padding: const EdgeInsets.only(top: 24, left: 12),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                // compass
                FloatingActionButton(
                  heroTag: "compassbtn",
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.rocket_outlined,
                    size: 28,
                    color: Color.fromRGBO(243, 166, 182, 1),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                // current locaction
                FloatingActionButton(
                  heroTag: "locabtn",
                  onPressed: _goToDefaultLocation,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.location_on_outlined,
                    size: 28,
                    color: Color.fromRGBO(243, 166, 182, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 21,
          ),
          Container(
            width: 56,
            padding: const EdgeInsets.only(top: 24, left: 12),
            alignment: Alignment.centerRight,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                // show room direction
                FloatingActionButton(
                  heroTag: "roombtn",
                  onPressed: () {
                    _showRoomDirection(context);
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.local_library_outlined,
                    size: 28,
                    color: Color.fromRGBO(243, 166, 182, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
