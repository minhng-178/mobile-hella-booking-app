import 'package:flutter/material.dart';
import 'package:travo_app/api/api_vehicle.dart';
import 'package:travo_app/models/vehicle_model.dart';
import 'package:travo_app/representation/screens/tour_booking_screen.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(TourBookingScreen.routeName);
      },
      child: Center(
        child: Text('Click me!'),
      ),
    );
  }
}
