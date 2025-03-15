import 'package:flutter/material.dart';
import 'package:movieapp/screens/main_screen.dart';
import 'package:movieapp/utils/dimension.dart';
import 'package:provider/provider.dart';

class OrientationChangeHandler extends StatelessWidget {
  const OrientationChangeHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final dimension = Provider.of<Dimension>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Update dimensions after the frame has been built
      if (mediaQuery.orientation == Orientation.portrait) {
        dimension.updateDimensions(
            mediaQuery.size.height, mediaQuery.size.width);
      } else {
        dimension.updateDimensions(
            mediaQuery.size.width, mediaQuery.size.height);
      }
  });

    return MoviesList();
  }
}