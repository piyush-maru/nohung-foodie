import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:share_plus/share_plus.dart';

class ReferAFriend extends StatefulWidget {
  final String referralCode;

  const ReferAFriend({required this.referralCode, Key? key}) : super(key: key);

  @override
  State<ReferAFriend> createState() => _ReferAFriendState();
}

class _ReferAFriendState extends State<ReferAFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6,
        leadingWidth: 200,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 8,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset("assets/images/backyellowbutton.png",
                    height: 28)),
            poppinsText(
                txt: "Refer your friend",
                maxLines: 3,
                fontSize: 18,
                textAlign: TextAlign.center,
                weight: FontWeight.w600),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SvgPicture.asset("assets/images/refer_screen.svg"),
            const SizedBox(
              height: 20,
            ),
            const _TextWithRow(
                text:
                    "Refer your friend & your friend will get Rs 50 on their very first order.",
                icon: "assets/images/refer_people.svg"),
            const SizedBox(
              height: 15,
            ),
            const _TextWithRow(
              text:
                  "Once your friend places the first order you will be rewarded Rs 50 to your wallet.",
              icon: "assets/images/refer_wallet.svg",
            ),
            const SizedBox(
              height: 25,
            ),
            const _TextWithRow(
              text: "Terms & Conditions",
              icon: "assets/images/refer_screen1.svg",
              isTitleBold: true,
            ),
            const SizedBox(
              height: 10,
            ),
            const _TextWithRow(
              isShowIcon: false,
              text: "Offer will be valid for Subscription & Order now  order.",
            ),
            const SizedBox(
              height: 10,
            ),
            const _TextWithRow(
              isShowIcon: false,
              text:
                  "Once your friends place the first order on your referral you will get the amount added to your NOHUNG wallet within 24 hrs",
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppConstant.appColor,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Referral Code : ",
                    style: AppTextStyles.normalText
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "${widget.referralCode} ",
                    style: AppTextStyles.boldText,
                  ),
                  const Spacer(),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                            text:
                                "${widget.referralCode} I have been using NOHUNG for my online homely food & Diet meal Subscription Delivery Service. I would like to refer you to use NOHUNG. Visit www.nohung.com >choose your favourite Kitchen and Subscription to a Plan> USE REFERAL CODE at checkout page and Get instant RS.50 on your first weekly/monthly subscription order."),
                      ).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Text Copied to Clipboard",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                        );
                      });
                    },
                    icon: const Icon(Icons.file_copy),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () async {
                      await Share.share(
                          "${widget.referralCode}\n\nI have been using NOHUNG for my online homely food & Diet meal Subscription Delivery Service. I would like to refer you to use NOHUNG. Visit www.nohung.com >choose your favourite Kitchen and Subscription to a Plan> USE REFERAL CODE at checkout page and Get instant RS.50 on your first weekly/monthly subscription order.",
                          subject:
                              "I have been using NOHUNG for my online homely food & Diet meal Subscription Delivery Service. I would like to refer you to use NOHUNG. Visit www.nohung.com >choose your favourite Kitchen and Subscription to a Plan> USE REFERAL CODE at checkout page and Get instant RS.50 on your first weekly/monthly subscription order.");
                    },
                    icon: const Icon(Icons.share),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const _TextWithRow(
              icon: "assets/icons/icon_description.svg",
              isTitleBold: true,
              text: "Description",
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    "For first 2 orders get 50rs off, after 2nd order 3-4 get 60rs off",
                    style: AppTextStyles.normalText
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TextWithRow extends StatelessWidget {
  final String text;
  final String? icon;
  final bool isShowIcon;
  final bool isTitleBold;
  const _TextWithRow(
      {required this.text,
      this.icon,
      this.isShowIcon = true,
      this.isTitleBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isShowIcon
            ? Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 8,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      )
                    ],
                    color: Colors.white),
                child: SvgPicture.asset(icon!),
              )
            : const SizedBox(
                width: 30,
              ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            text,
            style: isTitleBold
                ? AppTextStyles.titleText
                : AppTextStyles.normalText,
          ),
        ),
      ],
    );
  }
}
