import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/presentation/screen/landing/landing_screen.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:food_app/utils/utils.dart';

import '../../../model/login.dart';
import '../../../model/payment/deposit_payment.dart';

class Wallet extends StatefulWidget {
  final wallet;

  const Wallet(this.wallet, {Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextEditingController amount = TextEditingController();

  String url = "";

  String currentBalance = '';

  void getUser() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    userPersonalInfo.id.toString();
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();

    Future.delayed(Duration.zero, () {});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

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
                txt: "Nohung Wallet",
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 240,
                      child: Center(
                        child: Image.asset(
                          Res.paymentDefault1,
                        ),
                      )),
                  const SizedBox(height: 25),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(6.0),
                    ),
                    child: Container(
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                        //color: Colors.red,
                        borderRadius:
                        BorderRadius.circular(6.0), // Border radius
                      ),
                      child:  Center(
                        child: poppinsText(
                            txt: AppConstant.rupee + widget.wallet,
                            maxLines: 3,
                            fontSize: 24,
                            textAlign: TextAlign.center,
                            weight: FontWeight.w500),
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

  void addBalanceDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: dialog(context),
          );
        });
  }

  Widget dialog(BuildContext context) => Container(
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(
                maxLines: 1,
                autofocus: false,
                controller: amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Add Balance',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          AppConstant.appColor,
                        )),
                    child: Text(
                      "Add".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (amount.text.isEmpty) {
                        Utils.showToast("Please enter withdraw amount");
                      } else {
                        Navigator.pop(context);
                        withdrawPayment(amount.text);
                      }

                      // return Navigator.of(context).pop(true);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );

  withdrawPayment(String text) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    FormData from = FormData.fromMap(
        {"user_id": userPersonalInfo.id, "amount": text, "token": "123456789"});

    BeanDepositPayment? bean = await ApiProvider().depositPayment(from);

    if (bean?.status == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext context) => LandingScreen()));

      return bean;
    } else {
      Utils.showToast(bean!.message!);
    }

    return null;
  }
}
/*Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 20),
                        child: Image.asset(
                          Res.icRightArrow,
                          width: 40,
                          height: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        height: 180,
                        child: Center(
                          child: Image.asset(
                            Res.paymentDefault1,
                          ),
                        )),
                    const SizedBox(height: 25),
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 16),
                      child: Text(
                        "Total Balance",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 5),
                      child: Text(
                        AppConstant.rupee + widget.wallet,
                        style: const TextStyle(
                            color: AppConstant.lightGreen,
                            fontSize: 30,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
              ),
              /*  Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    addBalanceDialog();

*/ /*                  payment();*/ /*
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 16, top: 16),
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppConstant.appColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child:  Text(
                          "ADD BALANCE",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppConstant.fontBold,
                              fontSize: 10),
                        ),
                      ),

                  ),
                ),
              )*/
            ],
          ),
        ))*/