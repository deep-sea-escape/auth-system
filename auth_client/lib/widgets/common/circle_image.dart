import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final ImageProvider<Object>? image;
  final Color? backgroundColor;
  final double? radius;
  final Icon? placeHolderIcon;
  const CircleImage({
    this.image,
    this.radius,
    this.backgroundColor,
    this.placeHolderIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color actualBackgroundColor =
        backgroundColor != null ? backgroundColor! : colorScheme.background;
    return CircleAvatar(
      radius: radius,
      backgroundColor: actualBackgroundColor,
      backgroundImage: image,
      child: image == null ? placeHolderIcon : null,
    );
  }
}
