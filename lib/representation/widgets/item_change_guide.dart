import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/models/tourguide_model.dart';

class ItemChangeGuide extends StatefulWidget {
  final TourGuideModel guide;
  final ValueChanged<TourGuideModel> onSelected;

  const ItemChangeGuide(
      {super.key, required this.guide, required this.onSelected});

  @override
  _ItemChangeGuideState createState() => _ItemChangeGuideState();
}

class _ItemChangeGuideState extends State<ItemChangeGuide> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
          widget.onSelected(widget.guide);
        });
      },
      child: Card(
        color:
            selected ? ColorPalette.selectedColor : ColorPalette.primaryColor,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.guide.avatarUrl),
          ),
          title: Text(
            widget.guide.name,
            style: TextStyle(color: ColorPalette.backgroundScaffoldColor),
          ),
          subtitle: Text(
            'Languages: ${widget.guide.languages.join(', ')}',
            style: TextStyle(color: ColorPalette.backgroundScaffoldColor),
          ),
        ),
      ),
    );
  }
}
