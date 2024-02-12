import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants/app_constants.dart';

class HelpScreen3 extends StatefulWidget {
  const HelpScreen3({Key? key}) : super(key: key);

  @override
  State<HelpScreen3> createState() => _HelpScreen3State();
}

class _HelpScreen3State extends State<HelpScreen3> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Bottom(selectedIndex: 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(
                    "assets/images/white_backButton.png",
                    height: 23)),
            const SizedBox(width: 8),
            poppinsText(
                txt: "Help",
                maxLines: 3,
                fontSize: 16,
                textAlign: TextAlign.center,
                weight: FontWeight.w500),
          ],
        ),
        backgroundColor: const Color(0xffffb300),
        elevation: 0,
      ),
      backgroundColor: const Color(0xffffb300),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                top: 16,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  poppinsText(
                      txt:"Head Office",
                      maxLines: 3,
                      fontSize: 24,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500),
                  const SizedBox(height: 20),
                  Image.asset("assets/images/help_screen3.png",
                    height: 165,width: 165,),
                  const SizedBox(height: 10),
                  poppinsText(
                      txt:"301, Sri Laxmi Nilayam, Vinayak Nagar,\n Madhapur, Hyderabad",
                      maxLines: 3,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w400),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
