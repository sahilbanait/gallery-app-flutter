import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';

class ImageDetail extends StatefulWidget {
  const ImageDetail({Key? key}) : super(key: key);
  static const routName = '/imageDetail';

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  @override
  Widget build(BuildContext context) {
    final image = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Detail'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Padding(
                padding: EdgeInsets.only(top: 8, bottom: 30),
                child: GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: PinchZoom(
                      child: Image.network('$image'),
                      resetDuration: const Duration(milliseconds: 100),
                      maxScale: 2.5,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
