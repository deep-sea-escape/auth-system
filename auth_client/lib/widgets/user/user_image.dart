import 'package:flutter/material.dart';
import '../common/circle_image.dart';

class UserImage extends StatelessWidget {
  final ImageProvider<Object>? image;
  final double? radius;
  final Color? backgroundColor;
  const UserImage({
    this.image,
    this.radius,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color actualBackgroundColor =
        backgroundColor != null ? backgroundColor! : colorScheme.background;
    return CircleImage(
      backgroundColor: actualBackgroundColor,
      image: image,
      placeHolderIcon: Icon(
        Icons.person,
        color: colorScheme.primary,
        size: radius,
      ),
    );
  }
}
