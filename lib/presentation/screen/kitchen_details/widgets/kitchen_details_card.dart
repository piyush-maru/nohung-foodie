import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/customWidgets/image_error.dart';
import 'package:food_app/network/kitchen_details/kitchen_details_controller.dart';
import 'package:food_app/utils/Dimens.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/helper_class.dart';
import 'package:food_app/utils/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../model/menu_list_provider/menu_list_provider.dart';
import '../../../../model/offers_screen/offers_list_model.dart';
import '../../../../network/fav_kitchen_repo/fav_kitchen_model.dart';
import '../../../../network/kitchen_details/kitchen_details_model.dart';
import '../../../../utils/Utils.dart';
import '../../../../utils/constants/ui_constants.dart';

class KitchenDetailsCard extends StatefulWidget {
  const KitchenDetailsCard(
      {super.key,
      required this.myKitchenDetails,
      required this.kitchenDetailsProvider});
  final KitchenDetailsApi myKitchenDetails;
  final KitchenDetailsModel kitchenDetailsProvider;

  @override
  State<KitchenDetailsCard> createState() => _KitchenDetailsCardState();
}

class _KitchenDetailsCardState extends State<KitchenDetailsCard> {
  int slideIndex = 0;

  CarouselController carouselController = CarouselController();
  late bool isFav;
  late Future<OffersList> offerListFuture;

  @override
  void initState() {
    super.initState();
    isFav = widget.myKitchenDetails.data.first.isFavourite == "1";
    offerListFuture = widget.kitchenDetailsProvider.getOfferList(
      kitchenId: widget.myKitchenDetails.data.first.kitchenId ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final String apiData = widget.myKitchenDetails.data.first.timing;

    // Find the index of the closing parenthesis
    int closingParenthesisIndex = apiData.indexOf(')');

    // Extract the substring from the beginning to the closing parenthesis
    String truncatedData = apiData.substring(0, closingParenthesisIndex + 1);
    String output;
    try {
      output = truncatedData.substring(0, 12) +
          truncatedData.substring(truncatedData.length - 9);
    } catch (e) {
      output = '';
    }

    final favKitchenModel =
        Provider.of<FavKitchenModel>(context, listen: false);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(SizeConfig.defaultSize! * Dimens.size2),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white, //HexColor('#2f3443'),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                context.read<MenuListProvider>().updateMenuStatus(value: false);
                                context.read<KitchenDetailsModel>().resetFilters();
                                context.read<MenuListProvider>().updateSelectedMenuIndex(index: 0);
                                Navigator.of(context).pop();
                              },
                              child: Image.asset("assets/images/backyellowbutton.png",
                                  height: 24)),
                          /*InkWell(
                            onTap: () {
                              context
                                  .read<MenuListProvider>()
                                  .updateMenuStatus(value: false);
                              context
                                  .read<KitchenDetailsModel>()
                                  .resetFilters();
                              context
                                  .read<MenuListProvider>()
                                  .updateSelectedMenuIndex(index: 0);

                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: kYellowColor, width: 2)),
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),*/
                          const SizedBox(
                            width: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Container(
                              width: 70,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                child: Image.network(
                                  widget.myKitchenDetails!.data.first
                                      .profileImage,
                                  height: 70,
                                  errorBuilder:
                                      (BuildContext, Object, StackTrace) {
                                    return const ImageErrorWidget();
                                  },
                                  fit: BoxFit.fill,
                                  width: 115,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    widget.myKitchenDetails.data.first
                                        .kitchenName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppConstant.fontBold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4.0, top: 5),
                                  child: Text(
                                    widget.myKitchenDetails.data.first.foodType,
                                    maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: AppConstant.fontRegular,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.location_pin,
                                        color: Colors.orange, size: 14),
                                    const SizedBox(width: 3),
                                    FittedBox(
                                      child: Container(
                                        //  color: Colors.yellow,
                                        width: 120,
                                        child: Text(
                                          widget.myKitchenDetails.data.first
                                              .address,
                                          maxLines: 1,
                                          // overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: AppConstant.fontRegular,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (isFav) {
                            final res = await favKitchenModel.removeKitchenHttp(
                                widget.myKitchenDetails.data.first.kitchenId);
                            Utils.showToast(res!.message.toString());
                          } else {
                            final res = await favKitchenModel.favKitchenHttp(
                                widget.myKitchenDetails.data.first.kitchenId);
                            Utils.showToast(res!.message.toString());
                          }

                          setState(() {
                            isFav = !isFav;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(7),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                            shadows: [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: 17,
                            color: isFav
                                ? Colors.red
                                : Color(0xff2F3443), //const Color(0xff2F3443),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(32.0))),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Info",
                                                style: AppTextStyles
                                                    .semiBoldText
                                                    .copyWith(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              InkResponse(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: Colors.white,
                                                        shape: OvalBorder(
                                                          side: BorderSide(
                                                            width: 0.30,
                                                            strokeAlign: BorderSide
                                                                .strokeAlignCenter,
                                                            color: Color(
                                                                0x662F3443),
                                                          ),
                                                        ),
                                                        shadows: [
                                                          BoxShadow(
                                                            color: Color(
                                                                0x26000000),
                                                            blurRadius: 4,
                                                            offset:
                                                                Offset(0, 1),
                                                            spreadRadius: 0,
                                                          )
                                                        ],
                                                      ),
                                                      child: const Icon(
                                                        Icons.close,
                                                        size: 15,
                                                      )))
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 2),
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: OvalBorder(),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x26000000),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: poppinsText(
                                                  txt: 'i',
                                                  fontSize: 16,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              poppinsText(
                                                txt: '  About',
                                                fontSize: 16,
                                                weight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: widget
                                                        .myKitchenDetails
                                                        .data
                                                        .first
                                                        .kitchenName,
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: kTextPrimary),
                                                    )),
                                                TextSpan(
                                                  text:
                                                      ' ${widget.myKitchenDetails.data.first.about} dfdfdsd flkmds lkfmdsk fmlk fsmlkd fmlkdsmf lksdmf',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: kTextPrimary),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: OvalBorder(),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x26000000),
                                                      blurRadius: 4,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: const Icon(
                                                  Icons.phone,
                                                  size: 14,
                                                ),
                                              ),
                                              poppinsText(
                                                txt: '  Contact Us:',
                                                fontSize: 16,
                                                weight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Utils.makePhoneCall(
                                                      '7672057570');
                                                },
                                                child: poppinsText(
                                                  txt: ' 7672057570, ',
                                                  fontSize: 15,
                                                  weight: FontWeight.w400,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Utils.makePhoneCall(
                                                      '7498755331');
                                                },
                                                child: poppinsText(
                                                  txt: ' 7498755331',
                                                  fontSize: 15,
                                                  weight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: OvalBorder(),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x26000000),
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Icon(
                                  Icons.info,
                                  size: 17,
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              Utils.shareContent(Helper.shareKitchenContent(""
                                  /*widget.myKitchenDetails.data.first
                                      .kitchen_details_id*/
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.all(7),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: OvalBorder(),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x26000000),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.share,
                                size: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          // poppinsText(
                          //     txt: widget.myKitchenDetails.data.first
                          //                 .availableStatus ==
                          //             '0'
                          //         ? "Close Now"
                          //         : "Open Now",
                          //     fontSize: 13,
                          //     weight: FontWeight.w500,
                          //     color: widget.myKitchenDetails.data.first
                          //                 .availableStatus ==
                          //             '0'
                          //         ? Colors.red
                          //         : Colors.black),
                          (widget.myKitchenDetails.data.first.availableStatus ==
                                  '0')
                              ? RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Only SUBSCRIPTION Available Now\n',
                                    style: AppTextStyles.titleText.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Pre Order closed',
                                        style: AppTextStyles.titleText.copyWith(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 9),
                                      ),
                                    ],
                                  ),
                                )
                              : RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text:
                                        'SUBSCRIPTION & Pre Order Available Now,',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        color: Colors.green,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                          if (widget.myKitchenDetails.data.first
                                  .availableStatus ==
                              '1')
                            Text(
                              output,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstant.fontBold,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        color: AppConstant.appColor,
                        height: 40,
                        width: 1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 18,
                              ),
                              Text(
                                '${widget.myKitchenDetails.data.first.avgReview}.0',
                                maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: AppConstant.fontRegular,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${widget.myKitchenDetails.data.first.totalReview}+ Ratings",
                            maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: AppConstant.fontRegular,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        color: AppConstant.appColor,
                        height: 40,
                        width: 1,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "7 Meals",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppConstant.fontBold,
                            ),
                          ),
                          Text(
                            " per week",
                            maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: AppConstant.fontRegular,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder<OffersList>(
                  future: offerListFuture,
                  builder: (context, offersSnapshot) {
                    if (offersSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppConstant.appColor,
                        ),
                      );
                    }
                    if (offersSnapshot.hasError) {
                      return Center(
                        child: Text(
                          offersSnapshot.error.toString(),
                        ),
                      );
                    }
                    if (offersSnapshot.connectionState ==
                            ConnectionState.done &&
                        offersSnapshot.hasData) {
                      if (!offersSnapshot.data!.status) {
                        return SizedBox();
                      } else {
                        int totalSlides = offersSnapshot.data!.data!.length;

                        return Center(
                          child: Container(
                            height: 36,
                            width: 230,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset('assets/images/offer.svg',
                                        height: 25),
                                    const SizedBox(width: 8),
                                    Container(
                                      height: 36, //36
                                      width: 180,
                                      //color: Colors.yellow,
                                      child: CarouselSlider(
                                        carouselController: carouselController,
                                        options: CarouselOptions(
                                            viewportFraction: 1,
                                            onPageChanged: (val, _) {
                                              setState(() {
                                                slideIndex = val;
                                              });
                                            },
                                            autoPlayInterval:
                                                const Duration(seconds: 4),
                                            autoPlay: (totalSlides > 1)
                                                ? true
                                                : false,
                                            scrollPhysics: (totalSlides > 1)
                                                ? BouncingScrollPhysics()
                                                : NeverScrollableScrollPhysics(),
                                            height: 40.0,
                                            autoPlayCurve:
                                                Curves.fastOutSlowIn),
                                        items:
                                            offersSnapshot.data!.data!.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Align(
                                                alignment: Alignment.centerLeft,
                                                child: FittedBox(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      poppinsText(
                                                        txt: '${i.discountType == "0" ? "" : "₹ "}' +
                                                            "${Helper.convertStringToDoubleAndRemoveDecimal(i.discount)} ${Helper.getDiscountPercentOrFlat(i.discountType)}",
                                                        fontSize: 13,
                                                        weight: FontWeight.w600,
                                                        color: kTextPrimary,
                                                      ),
                                                      poppinsText(
                                                        txt: " OFF",
                                                        fontSize: 10,
                                                        weight: FontWeight.w500,
                                                        color: kTextPrimary,
                                                      ),
                                                      poppinsText(
                                                        txt: (i.discountType ==
                                                                "0")
                                                            ? " | Upto"
                                                            : " | Use Code ",
                                                        fontSize: 13,
                                                        weight:
                                                            (i.discountType ==
                                                                    "0")
                                                                ? FontWeight
                                                                    .w600
                                                                : FontWeight
                                                                    .w500,
                                                        color: kTextPrimary,
                                                      ),
                                                      poppinsText(
                                                        txt: (i.discountType ==
                                                                "0")
                                                            ? " ${AppConstant.rupee} ${i.upToAmount}/- off"
                                                            : i.offerCode,
                                                        fontSize: 13,
                                                        weight: FontWeight.w600,
                                                        color: kTextPrimary,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (totalSlides > 1)
                                      Column(
                                        children: [
                                          poppinsText(
                                            txt:
                                                "${slideIndex + 1}/${totalSlides}",
                                            fontSize: 11,
                                            weight: FontWeight.w600,
                                            color: kTextPrimary,
                                          ),
                                          DotsIndicator(
                                            decorator: const DotsDecorator(
                                              spacing:
                                                  EdgeInsets.only(left: 1.5),
                                              size: Size(6, 6),
                                              color:
                                                  Colors.grey, // Inactive color
                                              activeColor: AppConstant.appColor,
                                            ),
                                            dotsCount: totalSlides,
                                            position: slideIndex,
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppConstant.appColor,
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
