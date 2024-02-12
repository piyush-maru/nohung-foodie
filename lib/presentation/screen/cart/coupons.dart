import 'package:flutter/material.dart';
import 'package:food_app/network/cart_repo/cart_screen_model.dart';
import 'package:food_app/network/coupons_repo.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../model/cart_screen_class/apply_promo.dart';
import '../../../model/cart_screen_class/cart_screen_model_class.dart';

class CouponsScreen extends StatefulWidget {
  final String kitchenId;
  const CouponsScreen({required this.kitchenId, Key? key}) : super(key: key);

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  var applyPromoController = TextEditingController();
  bool showDiscount = false;
  Future? future;
  List<CartItem>? data;
  String? taxAmount = "";
  String? totalAmount = "";
  String? kitchenId = "";
  String? deliveryCharge = "";
  String? couponDiscount = "";
  var type = "";
  String? deliveryLat = "";
  String? deliveryLong = "";

  @override
  Widget build(BuildContext context) {
    final couponModel = Provider.of<CouponModel>(context, listen: false);
    final cartModel = Provider.of<CartScreenModel>(context, listen: false);
    //final kitchenId=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Apply Coupon",
          style: TextStyle(
              fontFamily: AppConstant.fontRegular, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: AppConstant.appColor,
      ),
      body: /*Column(
          // padding: const EdgeInsets.only(left: 16, right: 16),
          children: [
            const SizedBox(
                height: 200,
                child: Coupons(
                    discount: "Discount",
                    discountType: "Discount Type",
                    offerCode: "Offer Code")),*/
          SizedBox(
        height: 500,
        child: FutureBuilder(
            future: cartModel.applyPromo(
                widget.kitchenId, applyPromoController.text),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null
                  ? Consumer<BeanApplyPromo>(
                      builder: (context, snapshot, child) => ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Coupons(
                                discount: couponModel
                                    .getAllCoupons()[index]
                                    .discount
                                    .toString(),
                                discountType: couponModel
                                    .getAllCoupons()[index]
                                    .discountType,
                                offerCode: couponModel
                                    .getAllCoupons()[index]
                                    .offerCode);
                          }),
                    )
                  : const Text("No Coupons");
            }),
      ),
    );
  }

  // Future<BeanApplyPromo?> applyPromo() async {
  //   try {
  //     BeanLogin user = await Utils.getUser();
  //     FormData from = FormData.fromMap({
  //       "kitchen_id": widget.kitchenId,
  //       "token": "123456789",
  //       "user_id": userPersonalInfo.id,
  //       "coupon_code": applyPromoController.text.toString()
  //     });
  //
  //     BeanApplyPromo? bean = await ApiProvider().applyPromo(from);
  //
  //     if (bean?.status == true) {
  //       setState(() {
  //         showDiscount = true;
  //         future = getCartDetail();
  //       });
  //       return bean;
  //     } else {
  //       Utils.showToast(bean!.message!);
  //       setState(() {
  //         showDiscount = true;
  //         future = getCartDetail();
  //       });
  //     }
  //
  //     return null;
  //   } on HttpException {
  //     setState(() {
  //       showDiscount = true;
  //       future = getCartDetail();
  //     });
  //   } catch (exception) {
  //     setState(() {
  //       showDiscount = true;
  //       future = getCartDetail();
  //     });
  //   }
  //   return null;
  // }

  // Future<GetCartDetails?> getCartDetail() async {
  //   try {
  //     BeanLogin user = await Utils.getUser();
  //
  //     FormData from = FormData.fromMap({
  //       "token": "123456789",
  //       "user_id": userPersonalInfo.id,
  //     });
  //    GetCartDetails? bean = await ApiProvider().getCartDetail(from);
  //     if (bean?.status == true) {
  //       totalAmount = bean!.data.subTotal;
  //       taxAmount = bean.data.taxAmount;
  //       deliveryCharge = bean.data.deliveryCharge;
  //       couponDiscount = bean.data.couponDiscount;
  //       data = bean.data.cartItems;
  //       kitchenId = data![0].kitchenId;
  //       deliveryLat = bean.data.myLocation.latitude;
  //       deliveryLong = bean.data.myLocation.longitude;
  //       // deliveryAddress = bean.data!.myLocation!.address;
  //
  //       setState(() {});
  //       return bean;
  //     } else {
  //       Utils.showToast(bean!.message);
  //     }
  //
  //     return null;
  //   } on HttpException {
  //     setState(() {
  //       data = null;
  //     });
  //   } catch (exception) {
  //     setState(() {
  //       data = null;
  //     });
  //   }
  //   return null;
  // }
}

class Coupons extends StatelessWidget {
  final String offerCode;
  final String discountType;
  final String discount;

  const Coupons(
      {required this.discount,
      required this.discountType,
      required this.offerCode,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black.withOpacity(0.15)),
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      discountType,
                      style: const TextStyle(
                          fontFamily: AppConstant.fontBold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      discount,
                      style: const TextStyle(
                          fontFamily: AppConstant.fontRegular,
                          color: Colors.black),
                    )
                  ],
                ),
                Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.25),
                    ),
                    alignment: Alignment.topCenter,
                    child: Text(
                      offerCode,
                      style: const TextStyle(
                          fontFamily: AppConstant.fontBold,
                          color: Colors.purple),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
