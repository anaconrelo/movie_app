import 'package:flutter/material.dart';
import 'package:movieapp/utils/dimension.dart';
import 'package:movieapp/utils/typedefs.dart';
import 'package:movieapp/widgets/appbar.dart';
import 'package:movieapp/widgets/videoplayer.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;

class MovieScreen extends StatefulWidget {
  final JsonMap movie;
  const MovieScreen({super.key, required this.movie});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    html.document.onContextMenu.listen((event) => event.preventDefault());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dimension = Provider.of<Dimension>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dimension.getWidth(100),
              vertical: dimension.getHeight(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: dimension.getHeight(1),
              children: [
                Text(
                  widget.movie['title'],
                  style: textTheme.displayMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.movie['description'],
                  style: textTheme.headlineSmall!.copyWith(color: Colors.white),
                ),
                CustomVideoPlayer(
                  videoUrl: widget.movie['movie'],
                  isLooping: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
