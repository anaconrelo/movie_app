// Required for platform view registry
import 'package:flutter/material.dart';
import 'dart:html' as html;

class WebImageWidget extends StatefulWidget {
  @override
  State<WebImageWidget> createState() => _WebImageWidgetState();
}

class _WebImageWidgetState extends State<WebImageWidget> {
  final String imageUrl =
      "https://movieweb.anaconrelo.com/uploads/movieimage/2025/03/reversi.png";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerImageElement(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: 'network-image-$imageUrl');
  }

  void registerImageElement(String imageUrl) {
    final img =
        html.ImageElement()
          ..src = imageUrl
          ..crossOrigin = 'anonymous'; // Sometimes helps
    html.document.body!.append(img);
  }
}
