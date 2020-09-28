import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceMapScreen extends StatefulWidget {
  ServiceMapScreen({Key key}) : super(key: key);

  @override
  _ServiceMapScreenState createState() => _ServiceMapScreenState();
}

class _ServiceMapScreenState extends State<ServiceMapScreen> {

  // สร้าง object สำหรับไว้เรียกใช้ google map
  GoogleMapController mapController;

  // กำหนดสถานะเริ่มต้นโหลดแผนที่
  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  // กำหนดพิกัด Lat, Lon
  static const LatLng centerMap = const LatLng(13.8415427,100.5807104);
  
  // การสร้าง set marker
  // Set<Marker> baacMaker(){
  //   return <Marker>[
  //     Marker(
  //       position: centerMap,
  //       markerId: MarkerId('baacApp')
  //     )
  //   ].toSet();
  // }

  // สร้าง Set ของ Marker หลายจุด
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{
    MarkerId('baac-01'):Marker(
      markerId: MarkerId('baac-01'),
      position: LatLng(13.842297, 100.5772309),
      infoWindow: InfoWindow(
        title: 'ธกส. สำนักงานใหญ่',
        snippet: 'แขวงเสนานิคม เขตจตุจักร กรุงเทพฯ 10220'
      ),
      onTap: (){
        print('Marker tapped');
      }
    ),
    MarkerId('baac-02'):Marker(
      markerId: MarkerId('baac-02'),
      position: LatLng(13.841135, 100.545355),
      infoWindow: InfoWindow(
        title: 'ธนาคาร ธกส. สาขาย่อยประชาชื่น',
        snippet: '14 แขวงลาดยาว เขตจตุจักร กรุงเทพฯ 10900'
      ),
      onTap: (){
        print('Marker tapped');
      }
    ),
    MarkerId('baac-03'):Marker(
      markerId: MarkerId('baac-03'),
      position: LatLng(13.821531, 100.591431),
      infoWindow: InfoWindow(
        title: 'ธนาคารธกส.วังหิน',
        snippet: 'ลาดพร้าววังหิน 52 เขตลาดพร้าว กรุงเทพฯ 10230'
      ),
      onTap: (){
        print('Marker tapped');
      }
    ),
  };
  
  // สร้างฟังก์ชันเรียกแสดงแผนที่
  Widget myMap(){
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: centerMap,
        zoom: 15.0,
      ),
      mapType: MapType.normal,
      markers: Set<Marker>.of(markers.values),
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