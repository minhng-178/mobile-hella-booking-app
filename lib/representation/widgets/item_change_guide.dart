import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/models/tourguide_model.dart';

class ItemChangeGuide extends StatefulWidget {
  const ItemChangeGuide(
      {super.key, this.tourguideModel, required this.onSelected});

  final TourGuideModel? tourguideModel;
  final ValueChanged<TourGuideModel?> onSelected;

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
          widget.onSelected(widget.tourguideModel);
        });
      },
      child: Card(
        color:
            selected ? ColorPalette.selectedColor : ColorPalette.primaryColor,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                widget.tourguideModel?.user.image ?? AssetHelper.person),
          ),
          title: Text(
            widget.tourguideModel?.user.fullName ?? '',
            style: TextStyle(color: ColorPalette.backgroundScaffoldColor),
          ),
          subtitle: Text(
            'Languages: ${widget.tourguideModel?.language.join(', ')}',
            style: TextStyle(color: ColorPalette.backgroundScaffoldColor),
          ),
        ),
      ),
    );
  }
}
