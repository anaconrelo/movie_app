import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/utils/colors.dart';
import 'package:movieapp/utils/dimension.dart';
import 'package:movieapp/widgets/webimage.dart';
import 'package:provider/provider.dart';
import 'package:image_network/image_network.dart';

class MovieCard extends StatefulWidget {
  final String image;
  final String title;
  final WidgetBuilder movieScreen;
  const MovieCard({
    super.key,
    required this.image,
    required this.title,
    required this.movieScreen,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dimension = Provider.of<Dimension>(context);
    int cols = 0;

    double width = dimension.screenWidth;
    double height = dimension.screenHeight;
    if (dimension.screenWidth > 1000) {
      height = dimension.screenHeight / 8;
    } else if (dimension.screenWidth > 800) {
      height = dimension.screenHeight / 5;
    } else if (dimension.screenWidth > 600) {
      height = dimension.screenHeight / 2;
    } else {
      height = dimension.screenHeight / 1.5;
    }

    if (dimension.screenWidth > 1000) {
      cols = 6;
    } else if (dimension.screenWidth > 800 && dimension.screenWidth < 1000) {
      cols = 4;
    } else if (dimension.screenWidth > 600 && dimension.screenWidth < 800) {
      cols = 2;
    } else {
      cols = 1;
    }

    if (dimension.screenWidth > 1000) {
      width = dimension.screenWidth / cols;
    } else if (dimension.screenWidth > 800) {
      width = dimension.screenWidth / cols;
    } else if (dimension.screenWidth > 600) {
      width = dimension.screenWidth / cols;
    } else {
      width = dimension.screenWidth / cols;
    }

    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: widget.movieScreen));
      },
      onHover: (value) => setState(() => isHovered = value),
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: EdgeInsets.zero,
        backgroundColor: AppColors.bloodRed,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(dimension.getWidth(25)),
            clipBehavior: Clip.antiAlias,
            child: FittedBox(
              fit: BoxFit.cover, // Ensures the image behaves as expected
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.poppy,
                    width: isHovered ? 4 : 2,
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: ImageNetwork(
                  borderRadius: BorderRadius.circular(dimension.getWidth(25)),
                  image: widget.image,
                  width: width,
                  height: height,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: widget.movieScreen),
                    );
                  },
                ),
              ),
            ),
          ),
          //Container(
          //  height: height,
          //  width: width,
          //  decoration: BoxDecoration(
          //    borderRadius: BorderRadius.circular(dimension.getWidth(25)),
          //    image: DecorationImage(
          //      image: NetworkImage(widget.image),
          //      fit: BoxFit.fill,
          //    ),
          //    border: Border.all(
          //      color: AppColors.poppy,
          //      width: isHovered ? 4 : 2,
          //    ),
          //    color: Colors.grey,
          //  ),
          //),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            bottom: isHovered ? 0 : -height / 4,
            left: 0,
            right: 0,
            child: Container(
              height: (dimension.height / 2.5) / 4,
              width: dimension.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(dimension.getWidth(25)),
                  bottomRight: Radius.circular(dimension.getWidth(25)),
                ),
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: textTheme.bodyLarge!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
