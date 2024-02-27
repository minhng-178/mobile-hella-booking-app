import 'package:flutter/material.dart';
import 'package:travo_app/api/api_vehicle.dart';
import 'package:travo_app/models/vehicle_model.dart';

class VehicleWidget extends StatefulWidget {
  @override
  _VehicleWidgetState createState() => _VehicleWidgetState();
}

class _VehicleWidgetState extends State<VehicleWidget> {
  final ApiVehicles _apiVehicles = ApiVehicles();
  List<VehicleModel> _vehicles = [];

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  void _loadVehicles() async {
    _vehicles = await _apiVehicles.getAllVehicles();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicles'),
      ),
      body: ListView.builder(
        itemCount: _vehicles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_vehicles[index].vehicleName),
          );
        },
      ),
    );
  }
}
