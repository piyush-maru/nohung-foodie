import 'package:flutter/material.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen1 extends StatefulWidget {
  const HelpScreen1({Key? key}) : super(key: key);

  @override
  State<HelpScreen1> createState() => _HelpScreen1State();
}

class _HelpScreen1State extends State<HelpScreen1> {
  _sendingMails() async {
    var url = Uri.parse("mailto:contact@nohung.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                child: Image.asset("assets/images/white_backButton.png",
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
                      txt: "Business Related",
                      maxLines: 3,
                      fontSize: 24,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500),
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/help_screen1.png",
                    height: 165,
                    width: 165,
                  ),
                  const SizedBox(height: 10),
                  poppinsText(
                      txt:
                          "For business related enquiries, you may\n send us an email ",
                      maxLines: 3,
                      fontSize: 13,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w400),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        _sendingMails();
                      },
                      child: Container(
                        width: 260,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.email, size: 24),
                              const SizedBox(width: 4),
                              poppinsText(
                                  txt: "contact@nohung.com",
                                  maxLines: 3,
                                  fontSize: 18,
                                  textAlign: TextAlign.center,
                                  weight: FontWeight.w500),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
