import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryWidget extends StatefulWidget {
  final List<String> urlImages;

  const GalleryWidget({
    Key? key,
    required this.urlImages,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: PhotoViewGallery.builder(
        itemCount: widget.urlImages.length,
        builder: (context, index) {
          final urlImages = widget.urlImages[index];

          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(urlImages),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * 4,
          );
        },
      ));
}
