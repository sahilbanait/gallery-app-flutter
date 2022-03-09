import 'package:flutter/material.dart';
import 'package:gallery_app/model/image_provider.dart';
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
    final imageData = Provider.of<ImageList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GestureDetector(
          onTap: (){},
          child:Center(
            child: PinchZoom(
              child: Image.network('$image'),
              resetDuration: const Duration(milliseconds: 100),
              maxScale: 2.5,
            )

          ),
        )

      ),
    );
  }
}
