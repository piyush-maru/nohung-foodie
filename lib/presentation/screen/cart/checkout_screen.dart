import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/network/cart_repo/cart_screen_model.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../model/customized_package_detail.dart';
import '../../../network/check_out/checkout_model.dart';
import '../../../network/customization_details/customization_details_controller.dart';
import '../kitchen_details/customization_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final String mealPlan;

  //var user_id;
  final String package_id;
  final String customization;

  const CheckoutScreen(
      {Key? key,
      required this.package_id,
      required this.mealPlan,
      required this.customization})
      : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CheckOutModel>(context, listen: false)
          .customizedPackageDetailHttp(widget.package_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartScreenModel>(context, listen: false);
    final customizationDetailsController =
        Provider.of<CustomizationDetailsController>(context, listen: false);
    final checkOutModel = Provider.of<CheckOutModel>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder<BeanCustomizedPackageDetail?>(
            future:
                checkOutModel.customizedPackageDetailHttp(widget.package_id),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done &&
                      snapshot.data == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppConstant.appColor,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/images/leaf.svg',
                                    width: 18),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data!.data.packageName.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: AppConstant.fontRegular,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 28),
                          child: Text(
                            '₹ ${snapshot.data!.data.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: AppConstant.fontRegular,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 28),
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 400,
                              maxHeight: 100,
                            ),
                            child: Text(
                              snapshot.data!.data.cuisinetype.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 28),
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 400,
                              maxHeight: 100,
                            ),

                            ///TO DO ASK ASISH TO ADD Cutomization in this api
                            child: const Text(
                              'Customization Available',
                              style: TextStyle(
                                color: AppConstant.appColor,
                                fontFamily: AppConstant.fontBold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        ScrollbarTheme(
                          data: ScrollbarThemeData(
                            trackBorderColor: MaterialStateProperty.all(
                              Colors.grey,
                            ),
                            interactive: true,
                            radius: const Radius.circular(10.0),
                            thumbColor: MaterialStateProperty.all(
                              AppConstant.appColor,
                            ),
                            thickness: MaterialStateProperty.all(5.0),
                            minThumbLength: 800,
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width,
                              maxHeight:
                                  MediaQuery.of(context).size.height / 1.7,
                            ),
                            child: Scrollbar(
                              thumbVisibility: true,
                              controller: _scrollController,
                              interactive: true,
                              thickness: 10.0,
                              radius: const Radius.circular(20.0),
                              child: ListView.builder(
                                  controller: _scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      snapshot.data!.data.packageDetail?.length,
                                  itemBuilder: (context, ind) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${snapshot.data!.data.packageDetail?[ind].daysName},${snapshot.data!.data.packageDetail?[ind].date}',
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              AppConstant
                                                                  .fontBold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            customizationDetailsController
                                                                .getPackageCustomizableItemHttp(
                                                                    snapshot
                                                                        .data!
                                                                        .data
                                                                        .packageId,
                                                                    snapshot
                                                                        .data!
                                                                        .data
                                                                        .packageDetail?[
                                                                            ind]
                                                                        .weeklyPackageId);
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        CustomizationScreen(
                                                                  packageId: snapshot
                                                                          .data!
                                                                          .data
                                                                          .packageId ??
                                                                      "",
                                                                  weeklyPackageId: snapshot
                                                                          .data!
                                                                          .data
                                                                          .packageDetail?[
                                                                              ind]
                                                                          .weeklyPackageId ??
                                                                      "",
                                                                  packageName: snapshot
                                                                          .data!
                                                                          .data
                                                                          .packageName ??
                                                                      "",
                                                                  cuisineType: snapshot
                                                                          .data!
                                                                          .data
                                                                          .cuisinetype ??
                                                                      "",
                                                                  price: snapshot
                                                                          .data!
                                                                          .data
                                                                          .price ??
                                                                      "",
                                                                  customization:
                                                                      widget.customization ??
                                                                          "",
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'Customize',
                                                                style:
                                                                    TextStyle(
                                                                  color: AppConstant
                                                                      .appColor,
                                                                  fontFamily:
                                                                      AppConstant
                                                                          .fontBold,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SvgPicture.asset(
                                                                'assets/images/pencil.svg',
                                                                color: AppConstant
                                                                    .appColor,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: snapshot
                                                    .data!
                                                    .data
                                                    .packageDetail?[ind]
                                                    .items
                                                    ?.length,
                                                itemBuilder: (context, i) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .data
                                                              .packageDetail![
                                                                  ind]
                                                              .items![i]
                                                              .varPrice!
                                                              .toDouble()
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                AppConstant
                                                                    .fontRegular,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          snapshot
                                                                  .data!
                                                                  .data
                                                                  .packageDetail?[
                                                                      ind]
                                                                  .items?[i]
                                                                  .itemname ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                AppConstant
                                                                    .fontRegular,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                  minHeight: 60,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        '₹ ${snapshot.data!.data.price}',
                                        style: const TextStyle(
                                          color: AppConstant.appColor,
                                          fontFamily: AppConstant.fontBold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Order For',
                                      style: TextStyle(
                                        fontFamily: AppConstant.fontBold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'For ${snapshot.data!.data.countDays} Days',
                                      style: const TextStyle(
                                        fontFamily: AppConstant.fontBold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 8.0, right: 8.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppConstant.appColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        constraints: BoxConstraints(
                                          maxHeight: 60,
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6.0,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.arrow_back),
                                              Text(
                                                'Back',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontBold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        // cartModel.getCartCount().then((value) {
                                        //
                                        //
                                        //   cartModel.addToCart(
                                        //       snapshot.data!.data
                                        //           .kitchenId,
                                        //       widget.mealPlan,
                                        //       snapshot.data!.data
                                        //           .packageId,
                                        //      // '1',
                                        //       //'1',
                                        //       );
                                        // });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppConstant.appColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        constraints: BoxConstraints(
                                          maxHeight: 60,
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6.0,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Checkout',
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontBold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Icon(Icons.arrow_forward)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
