import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../model/offers_screen/offers_list_model.dart';
import '../../../network/cart_repo/cart_screen_model.dart';
import '../../../network/kitchen_details/kitchen_details_controller.dart';
import '../../../utils/Utils.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../../utils/helper_class.dart';

class AllOffersScreen extends StatefulWidget {
  final String kitchenID;
  const AllOffersScreen({
    super.key,
    required this.kitchenID,
  });

  @override
  State<AllOffersScreen> createState() => _AllOffersScreenState();
}

class _AllOffersScreenState extends State<AllOffersScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    final kitchenDetailsProvider =
        Provider.of<KitchenDetailsModel>(context, listen: false);
    final cartProvider = Provider.of<CartScreenModel>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFFB200),
        leadingWidth: 120,
        leading: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/white_backButton.png',
                  width: 25,
                ),
              ),
            ),
            poppinsText(
                txt: "All Offers",
                fontSize: 20,
                weight: FontWeight.w600,
                color: Colors.black),
          ],
        ),
      ),
      body: FutureBuilder<OffersList>(
        future: kitchenDetailsProvider.getOfferList(
          kitchenId: widget.kitchenID ?? "",
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppConstant.appColor,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final offerList = snapshot.data?.data ?? [];
            return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Offers for you",
                          style: AppTextStyles.semiBoldText.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkResponse(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (offerList!.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Text(
                          "No offers available.",
                          style: AppTextStyles.titleText,
                        ),
                      ),
                    ...offerList.map(
                      (e) => Container(
                          height: 120,
                          margin: EdgeInsets.only(
                            bottom: 17,
                          ),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 7),
                                decoration: const BoxDecoration(
                                  color: AppConstant.appColor,
                                ),
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: poppinsText(
                                        txt: '${e.discountType == '1' ? '${AppConstant.rupee}' : ''}' +
                                            "${Helper.convertStringToDoubleAndRemoveDecimal(e.discount)} ${Helper.getDiscountPercentOrFlat(e.discountType)}" +
                                            '${e.discountType == '1' ? '/-' : ''}' +
                                            "OFF",
                                        maxLines: 1,
                                        fontSize: 16,
                                        textAlign: TextAlign.center,
                                        weight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/offer.svg',
                                              height: 25),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          poppinsText(
                                              txt: e.offerCode,
                                              fontSize: 16,
                                              textAlign: TextAlign.center,
                                              weight: FontWeight.w600),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              /*   showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  List<String> tcPoints = [
                                                    '• This offer is personalised for you.',
                                                    '• Maximum instant discount of ₹${e.upToAmount}.',
                                                    '• Applicable only on selected restaurants.',
                                                    '• Applicable maximum 3 times in a day.',
                                                    '• Other T&C\'s may apply.'
                                                  ];
                                                  return AlertDialog(
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              poppinsText(
                                                                  txt:
                                                                      "Terms & Conditions",
                                                                  fontSize: 16,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  weight:
                                                                      FontWeight
                                                                          .w700),
                                                              InkResponse(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Icon(
                                                                      Icons
                                                                          .close))
                                                            ]),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        ...tcPoints.map(
                                                          (e) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        5.0),
                                                            child: Text(
                                                              e,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      AppConstant
                                                                          .fontRegular),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );*/
                                            },
                                            child: Text(
                                              'T&C Apply',
                                              style: TextStyle(
                                                color: Color(0xFF3570D2),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: poppinsText(
                                            txt: 'Use code ${e.offerCode} & get' +
                                                ' ${e.discountType == '1' ? '${AppConstant.rupee}' : ''}' +
                                                '${Helper.convertStringToDoubleAndRemoveDecimal(e.discount)} ${Helper.getDiscountPercentOrFlat(e.discountType)} off',
                                            fontSize: 13,
                                            color: Color(0xFF2F3443),
                                            textAlign: TextAlign.center,
                                            weight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          onTap: () async {
                                            final res = await cartProvider
                                                .applyCouponCode(
                                                    couponCode: e.offerCode,
                                                    kitchenID:
                                                        widget.kitchenID);

                                            if (res.status) {
                                              cartProvider.updateCouponCode(
                                                  e.offerCode);
                                              Utils.showToast(res.message);
                                            } else if (!res.status) {
                                              Utils.showToast(res.message!);
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 12),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                border: Border.all(
                                                    color: Colors.black26)),
                                            child: poppinsText(
                                                txt: "APPLY COUPON",
                                                fontSize: 16,
                                                color: Color(0xB202B418),
                                                textAlign: TextAlign.center,
                                                weight: FontWeight.w700),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ));
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppConstant.appColor,
            ),
          );
        },
      ),
    );
  }
}
