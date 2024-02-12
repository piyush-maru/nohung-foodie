import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/utils/constants/app_constants.dart';

import '../utils/constants/ui_constants.dart';

class IconText extends StatefulWidget {
  final text;
  final IconData icon;

  const IconText(
      {Key? key, this.text, required this.icon, required TextStyle style})
      : super(key: key);

  @override
  State<IconText> createState() => _IconTextState();
}

class _IconTextState extends State<IconText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            widget.icon,
            color: Colors.white,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 180),
            child: Text(widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: AppConstant.fontRegular,
                )),
          ),
        ],
      ),
    );
  }
}

class IconText2 extends StatefulWidget {
  final String text;
  final IconData icon;

  const IconText2({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  State<IconText2> createState() => _IconText2State();
}

class _IconText2State extends State<IconText2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            widget.icon,
            color: AppConstant.appColor,
            size: 15,
          ),
          Text(widget.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: AppConstant.fontRegular,
              )),
        ],
      ),
    );
  }
}

class CuisineTypeText extends StatefulWidget {
  final text;
  final color;

  const CuisineTypeText({Key? key, this.text, this.color}) : super(key: key);

  @override
  State<CuisineTypeText> createState() => _CuisineTypeTextState();
}

class _CuisineTypeTextState extends State<CuisineTypeText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Container(
        // width: 85,
        padding:
            const EdgeInsets.only(left: 4.0, right: 4.0, top: 5, bottom: 5),
        decoration: const BoxDecoration(
          color: kLightYellowColor,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            widget.text ?? "s",
            style: const TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontFamily: AppConstant.fontRegular),
          ),
        ),
      ),
    );
  }
}

class FilterImageAndText extends StatefulWidget {
  final String image;

  final String text;
  final Color color;

  const FilterImageAndText(
      {Key? key, required this.image, required this.text, required this.color})
      : super(key: key);

  @override
  State<FilterImageAndText> createState() => _FilterImageAndTextState();
}

class _FilterImageAndTextState extends State<FilterImageAndText> {
  @override
  Widget build(BuildContext context) {
    return widget.image != ''
        ? Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey,
                ),
                color: widget.color,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, bottom: 4.0, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(widget.image.toString()),
                    Text(
                      widget.text,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  width: 1.0,
                  color: Colors.black,
                ),
                color: widget.color,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, bottom: 4.0, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.text,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class FilterImageAndText1 extends StatefulWidget {
  final String image;

  final String text;
  final Color color;

  const FilterImageAndText1(
      {Key? key, required this.image, required this.text, required this.color})
      : super(key: key);

  @override
  State<FilterImageAndText1> createState() => _FilterImageAndText1State();
}

class _FilterImageAndText1State extends State<FilterImageAndText1> {
  @override
  Widget build(BuildContext context) {
    return widget.image != ''
        ? Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey,
                ),
                color: widget.color,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 6.0, bottom: 6.0, left: 6, right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(widget.image.toString(), height: 18),
                    Text(
                      widget.text,
                      style: const TextStyle(
                          fontSize: 12, //16
                          color: Colors.black,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  width: 1.0,
                  color: Colors.black,
                ),
                color: widget.color,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 4.0, bottom: 4.0, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.text,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
