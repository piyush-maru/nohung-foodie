import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


/*

errorBuilder: (BuildContext,
Object, StackTrace) {
return ImageErrorWidget();
},


*/


class ImageErrorWidget extends StatefulWidget {
  const ImageErrorWidget({Key? key}) : super(key: key);

  @override
  State<ImageErrorWidget> createState() => _ImageErrorWidgetState();
}

class _ImageErrorWidgetState extends State<ImageErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/images/image_error.svg');
  }
}
