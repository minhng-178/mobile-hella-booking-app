import 'package:flutter/material.dart';

List<TourGuide> tourguides = [
  TourGuide(
      name: 'John Doe',
      imageUrl: 'https://example.com/images/john_doe.jpg',
      experience: '5 years',
      language: 'English, Spanish'),
  TourGuide(
      name: 'Jane Smith',
      imageUrl: 'https://example.com/images/jane_smith.jpg',
      experience: '3 years',
      language: 'English, French'),
  TourGuide(
      name: 'Bob Johnson',
      imageUrl: 'https://example.com/images/bob_johnson.jpg',
      experience: '10 years',
      language: 'English, German'),
  // Add more tour guides as needed
];

class TourGuide {
  String name;
  final String imageUrl;
  final String experience;
  final String language;

  TourGuide(
      {required this.name,
      required this.imageUrl,
      required this.experience,
      required this.language});
}

class ItemChangeTourguide extends StatefulWidget {
  final TourGuide initData;
  final Function(TourGuide) onTourguideChanged;

  ItemChangeTourguide(
      {required this.initData, required this.onTourguideChanged});

  @override
  _ItemChangeTourguideState createState() => _ItemChangeTourguideState();
}

class _ItemChangeTourguideState extends State<ItemChangeTourguide> {
  late TourGuide selectedTourguide;

  @override
  void initState() {
    super.initState();
    selectedTourguide = widget.initData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Name: ${selectedTourguide.name}'),
        Image.network(selectedTourguide.imageUrl),
        Text('Experience: ${selectedTourguide.experience}'),
        Text('Language: ${selectedTourguide.language}'),
        DropdownButton<TourGuide>(
          value: selectedTourguide,
          onChanged: (TourGuide? newTourguide) {
            if (newTourguide != null) {
              setState(() {
                selectedTourguide = newTourguide;
              });
              widget.onTourguideChanged(newTourguide);
            }
          },
          items: tourguides.map((TourGuide tourguide) {
            return DropdownMenuItem<TourGuide>(
              value: tourguide,
              child: Text(tourguide.name),
            );
          }).toList(),
        ),
      ],
    );
  }
}
