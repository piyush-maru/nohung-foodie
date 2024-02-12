import 'package:flutter/material.dart';
import 'package:food_app/res.dart';

import '../utils/constants/app_constants.dart';

class SuccessPackageScreen extends StatefulWidget {
  const SuccessPackageScreen({Key? key}) : super(key: key);

  @override
  _SuccessPackageScreenState createState() => _SuccessPackageScreenState();
}

class _SuccessPackageScreenState extends State<SuccessPackageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 200,
              child: Center(
                child: Image.asset(
                  Res.packageSuccess,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                "SUCCESSFULLY PACKAGE UPLOAD",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: AppConstant.fontBold,
                    fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                "To Create Many Packages\nclick to add another packages",
                style: TextStyle(
                    color: Color(0xffA7A8BC),
                    fontFamily: AppConstant.fontRegular,
                    fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 60, bottom: 15),
                height: 55,
                width: 200,
                decoration: BoxDecoration(
                    color: const Color(0xffFFA451),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
              ),
            ),
          ],
        ),
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
