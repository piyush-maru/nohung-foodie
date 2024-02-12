import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:hexcolor/hexcolor.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'oops',
              style: TextStyle(
                fontSize: 25,
                fontFamily: AppConstant.fontBold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset('assets/images/network.svg',
                width: 100, height: 200),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Check Internet',
              style: TextStyle(
                fontSize: 25,
                fontFamily: AppConstant.fontBold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'There is no internet connection',
              style: TextStyle(
                fontSize: 16,
                color: HexColor('#2f3443'),
                fontFamily: AppConstant.fontBold,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
