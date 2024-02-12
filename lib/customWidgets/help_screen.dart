import 'package:flutter/material.dart';
import 'package:food_app/customWidgets/help_screen1.dart';
import 'package:food_app/customWidgets/help_screen2.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  // 'assets/images/business.svg',
  //'assets/images/support.svg',
  // 'assets/images/head_office.svg',
  int ind = -1;
  var listImages = [
    'Business Related',
    'For Support',
    // 'Head Office',
  ];
  var list = [
    '''For business related enquiries,
  you may send us an email''',
    '''For support, you can call us
on our toll free number
or send us an email''',
    '''301, Sri Laxmi Nilayam,
Vinayak Nagar,
Madhapur, Hyderabad''',
  ];
  var emailList = [
    'contact@nohung.com',
    'support@nohung.com',
    '',
  ];
  var headings = [
    'Business related',
    'For support',
    'Head Office',
  ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  _sendingMails() async {
    var url = Uri.parse("mailto:contact@nohung.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendingMails1() async {
    var url = Uri.parse("mailto:support@nohung.com");
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
                  Image.asset(
                    "assets/images/help_image.png",
                    height: 165,
                    width: 165,
                  ),
                  const SizedBox(height: 8),
                  poppinsText(
                      txt: "How can we help you?",
                      maxLines: 3,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500),
                  const SizedBox(height: 40),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: listImages.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 10),
                                    child: InkWell(
                                      onTap: () {
                                        //_sendingMails1();
                                        setState(() {
                                          ind = i;
                                        });
                                        if (ind == 0) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HelpScreen1()),
                                          );
                                        } else if (ind == 1) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HelpScreen2()),
                                          );
                                        }

                                        // else if(ind==2){
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(builder: (context) => const HelpScreen3()),
                                        //   );
                                        // }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          poppinsText(
                                              txt: listImages[i],
                                              maxLines: 3,
                                              fontSize: 16,
                                              textAlign: TextAlign.center,
                                              weight: FontWeight.w500),
                                          const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                              size: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                  /* InkWell(
                                  onTap: () {
                                    _sendingMails1();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Visibility(
                                          visible: i == 2 ? false : true,
                                          child: const Icon(Icons.email_outlined)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          emailList[i],
                                          style: const TextStyle(
                                              fontFamily:
                                                  AppConstant.fontRegular),
                                        ),
                                      ),
                                    ],
                                  )),*/
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
