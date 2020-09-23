import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceMapScreen extends StatefulWidget {
  ServiceMapScreen({Key key}) : super(key: key);

  @override
  _ServiceMapScreenState createState() => _ServiceMapScreenState();
}

class _ServiceMapScreenState extends State<ServiceMapScreen> {

  // กำหนดพิกัด Lat, Lon
  static const LatLng centerMap = const LatLng(13.8415427,100.5807104);
  
  // การสร้าง set marker
  Set<Marker> baacMaker(){
    return <Marker>[
      Marker(
        position: centerMap,
        markerId: MarkerId('baacApp')
      )
    ].toSet();
  }
  
  // สร้างฟังก์ชันเรียกแสดงแผนที่
  Widget myMap(){
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: centerMap,
        zoom: 16.0,
      ),
      mapType: MapType.normal,
      markers: baacMaker(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('พื้นที่ให้บริการของเรา'),
      ),
       body: myMap(),
    );
  }
}