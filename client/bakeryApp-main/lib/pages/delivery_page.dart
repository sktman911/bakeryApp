import 'dart:async';

import 'package:demo_app/components/Map/MapTextField.dart';
import 'package:demo_app/conf/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class DeliveryPage extends StatefulWidget {
  final TextEditingController addressController;
  const DeliveryPage({super.key, required this.addressController});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  @override
  void initState() {
    super.initState();
    _markers.add(
      const Marker(
        markerId: MarkerId('shopLocation'),
        icon: BitmapDescriptor.defaultMarker,
        position: _shopPos,
      ),
    );

    setLocation().then((_) => {setPolylinePoints().then((value) => {})});
  }

  final Completer<GoogleMapController> _mapController = Completer();
  TextEditingController textController = TextEditingController();
  final Set<Marker> _markers = {};
  bool isMove = false;

  double searchInputWidth = 320;

  // default shop location
  static const _shopPos = LatLng(10.775782, 106.667379);

  static LatLng? currentPos;
  Location? onTapLocation;

  static List<Placemark> _placemark = [];
  static List<Placemark> hintPlace = [];
  Placemark? firstPlaceMark;

  Map<PolylineId, Polyline> polylines = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: customOrange,
          ),
        ),
      ),
      body: currentPos == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: ((GoogleMapController controller) =>
                      _mapController.complete(controller)),
                  initialCameraPosition:
                      CameraPosition(target: currentPos!, zoom: 20),
                  markers: _markers,
                  polylines: Set<Polyline>.of(polylines.values),
                  onTap: (pos) {
                    _addMarker(pos);
                  },
                ),
                Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width / 2 -
                        searchInputWidth / 2,
                    height: 120,
                    width: searchInputWidth,
                    child: MapTextField(
                      markers: _markers,
                      mapController: _mapController,
                      location: onTapLocation,
                      placemark: firstPlaceMark,
                      lstPlaceMark: hintPlace,
                      textController: textController,
                    ))
              ],
            ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              widget.addressController.text =
                  "${firstPlaceMark!.name!} ${firstPlaceMark!.subAdministrativeArea!} ${firstPlaceMark!.administrativeArea!}";
            });
            Navigator.pop(context);
          },
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(customOrange)),
          child: const Text(
            'Set this position',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // camera move by marker
  Future<void> cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPos = CameraPosition(target: pos, zoom: 20);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPos));
  }

  // set Location
  Future<void> setLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    Position initPos = await Geolocator.getCurrentPosition();
    List<Placemark> placemark = await initPlacemark(initPos);

    setState(() {
      currentPos = LatLng(initPos.latitude, initPos.longitude);
      initLocation(initPos);
      _markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        icon: BitmapDescriptor.defaultMarker,
        position: currentPos!,
      ));

      cameraToPosition(currentPos!);
      _placemark = placemark;
      firstPlaceMark = placemark[0];
      getPlaceList(currentPos);
      setNewAddress(currentPos!);
    });

    // locationController.onLocationChanged.listen((LocationData currentLocation) {
    //   if (currentLocation.latitude != null &&
    //       currentLocation.longitude != null) {
    //     setState(() {
    //       currentPos =
    //           LatLng(currentLocation.latitude!, currentLocation.longitude!);

    //       _markers.add(Marker(
    //         markerId: const MarkerId('currentLocation'),
    //         icon: BitmapDescriptor.defaultMarker,
    //         position: currentPos!,
    //       ));

    //       cameraToPosition(currentPos!);
    //     });
    //   }
    // });
  }

  // set Polyline
  Future<List<LatLng>> setPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapAPIKey,
      PointLatLng(currentPos!.latitude, currentPos!.longitude),
      PointLatLng(_shopPos.latitude, _shopPos.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  // draw polyline
  Future<void> generatePolylineFromPoint(List<LatLng> polylineCordinate) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
        polylineId: id,
        color: Colors.blueAccent,
        points: polylineCordinate,
        width: 5);

    setState(() {
      polylines[id] = polyline;
    });
  }

  getPlaceList(newPos) async {
    List<Placemark> placeList =
        await placemarkFromCoordinates(newPos.latitude, newPos.longitude);
    hintPlace = placeList;
  }

  // set new pos
  _addMarker(newPos) {
    setState(() {
      _markers.removeWhere(
          (element) => element.markerId.value == 'currentLocation');

      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: newPos,
          infoWindow: const InfoWindow(
            title: 'My Position',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      cameraToPosition(newPos);
      getPlaceList(newPos);
      setNewAddress(newPos);
    });
  }

  setNewAddress(LatLng pos) async {
    _placemark = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    firstPlaceMark = _placemark[0];
    textController.text =
        "${firstPlaceMark!.street!} ${firstPlaceMark!.subAdministrativeArea!} ${firstPlaceMark!.administrativeArea!}";
  }

  // create init placemark
  Future<List<Placemark>> initPlacemark(Position pos) async {
    return _placemark =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
  }

  // create init location
  initLocation(Position pos) {
    onTapLocation = Location(
        latitude: pos.latitude,
        longitude: pos.longitude,
        timestamp: DateTime.timestamp());
  }
}
