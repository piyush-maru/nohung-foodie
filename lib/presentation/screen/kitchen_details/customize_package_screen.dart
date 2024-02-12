import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/model/customized_package_detail.dart' as custom;
import 'package:food_app/res.dart';
import 'package:food_app/utils/constants/app_constants.dart';

class CustomizePackageScreen extends StatefulWidget {
  final String packageId;
  final String kitchenId;
  final String bookType;

  const CustomizePackageScreen(this.packageId, this.kitchenId, this.bookType,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PackageDetailScreenState();
}

class PackageDetailScreenState extends State<CustomizePackageScreen> {
  List<custom.PackageDetail>? packageDetail;

  String? mealFor = "";
  String? packageId = "";
  String? kitchenId = "";
  String? cuisineType = "";
  String? mealType = "";
  String? packageName = "";
  String address = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      //packageDetailApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          packageName!.toUpperCase(),
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 12, right: 12),
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  mealFor!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontRegular,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                Row(
                  children: [
                    Image.asset(
                      Res.veg,
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      mealType!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                Text(
                  cuisineType!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
            ),
            if (packageDetail == null)
              const Center(
                child: Text("No Package Available"),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const SizedBox();
                  // return getPackage(packageDetail![index]);
                },
                itemCount: packageDetail!.length,
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(400, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Text('Add to Cart'),
              onPressed: () {
                //addToCart();
              },
            ),
          ],
        ),
      ),
    );
  }

  // addToCart() async {
  //   BeanLogin user=await Utils.getUser();
  //   FormData from = FormData.fromMap({
  //     "user_id": userPersonalInfo.id,
  //     "token": "123456789",
  //     "kitchen_id": widget.kitchenId,
  //     "type_id": widget.packageId,
  //     "mealplan": widget.bookType,
  //     "quantity": "1",
  //     "quantity_type": "1"
  //   });
  //
  //   BeanAddCart? bean = await ApiProvider().addCart(from);
  //
  //   if (bean?.status == true) {
  //     Utils.showToast(bean!.message!);
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) =>  ShippingScreen("user.data!.address.toString()", kitchenId.toString())),
  //         (route) => false);
  //
  //     return bean;
  //   } else {
  //     Utils.showToast(bean!.message!);
  //   }
  //   return null;
  // }
}
