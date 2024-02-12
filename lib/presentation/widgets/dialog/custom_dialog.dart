import 'package:flutter/material.dart';

import '../../../utils/constants/ui_constants.dart';

void showCustomDialog({
  required BuildContext context,
  required String title,
  required List subtitles,
  Widget? widget,
}) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetAnimationDuration: const Duration(seconds: 1),
          backgroundColor: Colors.black45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            // Set rounded corners
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.campaign,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    poppinsText(
                      txt: title,
                      fontSize: 18,
                      weight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ...subtitles.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 6,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CircleAvatar(
                      //   radius: 5,
                      //   backgroundColor: kWhite,
                      // ),
                      const Text(
                        '\u2022',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: poppinsText(
                            txt: e,
                            fontSize: 15,
                            color: Colors.white,
                            weight: FontWeight.w500,
                            maxLines: 5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              if (widget != null)
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                  child: widget,
                )
            ]),
          ),
        );
      });
}

void showCustomDialogSimple({
  required BuildContext context,
  required String title,
  required String subtitle,
}) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  poppinsText(
                      txt: title,
                      fontSize: 18,
                      weight: FontWeight.w600,
                      color: Colors.black,
                      textAlign: TextAlign.start),
                  const SizedBox(
                    height: 10,
                  ),
                  poppinsText(
                      txt: subtitle,
                      fontSize: 16,
                      weight: FontWeight.w500,
                      color: kTextPrimary,
                      maxLines: 4,
                      textAlign: TextAlign.start),
                ],
              ),
            ),
          ),
        );
      });
}
