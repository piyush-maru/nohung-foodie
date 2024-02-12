import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/customWidgets/image_error.dart';
import 'package:food_app/model/home_screen_model/home_screen_model.dart';
import 'package:food_app/network/fav_kitchen_repo/fav_kitchen_model.dart';
import 'package:food_app/presentation/screen/authentication_screens/login/login_with_mobile_screen.dart';
import 'package:food_app/presentation/screen/kitchen_details/kitchen_details_screen.dart';
import 'package:food_app/utils/Dimens.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/size_config.dart';
import 'package:food_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../../utils/pref_manager.dart';

class KitchenDetailsHomeScreenCard extends StatefulWidget {
  const KitchenDetailsHomeScreenCard({super.key, required this.snapshot});
  final HomeKitchenData snapshot;
  @override
  State<KitchenDetailsHomeScreenCard> createState() =>
      _KitchenDetailsHomeScreenCardState();
}

class _KitchenDetailsHomeScreenCardState
    extends State<KitchenDetailsHomeScreenCard> {
  late bool isFav;
  @override
  void initState() {
    super.initState();
    isFav = widget.snapshot.isFavourite == "1";
  }

  @override
  Widget build(BuildContext context) {
    final favKitchenModel =
        Provider.of<FavKitchenModel>(context, listen: false);
    final dataList = widget.snapshot.cuisineType.split(',');
    final firstThreeData = dataList.take(3).toList();
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.only(
        // top: SizeConfig.defaultSize! *
        //   Dimens.size1,
        bottom: SizeConfig.defaultSize! * Dimens.size1,
        left: SizeConfig.defaultSize! * Dimens.size1,
        right: SizeConfig.defaultSize! * Dimens.sizePoint9,
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KitchenDetailsScreen(
                      widget.snapshot.kitchenId,
                      OrderCategory.Subscription.toJsonKey()),
                ),
              );
            },
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                height: 290,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 180.0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Image.network(
                          widget.snapshot.image,
                          errorBuilder: (BuildContext, Object, StackTrace) {
                            return const ImageErrorWidget();
                          },
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.snapshot.kitchenName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: AppConstant.fontBold),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                SvgPicture.asset('assets/images/timings.svg',
                                    height: 16),
                                // const SizedBox(width: 4),
                                Text(
                                  '  ${widget.snapshot.time}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4),
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/type_of_meal.svg',
                                  height: 16,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    firstThreeData
                                        .toString()
                                        .replaceAll('[', '')
                                        .replaceAll(']', ''),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                        fontFamily: AppConstant.fontRegular,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                const SizedBox(width: 80),
                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                                const Text(
                                  " Starting from ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "₹${widget.snapshot.startingPrice}/-",
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "meal",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 290,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      padding: EdgeInsets.all(5),
                      decoration: const ShapeDecoration(
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
                      child: widget.snapshot.foodType == "Veg"
                          ?SvgPicture.asset('assets/images/leaf.svg')
                          :widget.snapshot.foodType == "Veg/Non Veg"
                          ?SvgPicture.asset('assets/images/both.svg')
                          :SvgPicture.asset('assets/images/chicken.svg'),
                    ),
                    Spacer(),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const ShapeDecoration(
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
                      child: InkWell(
                        onTap: () async {
                          final isLoggedIn =
                              await PrefManager.getBool(AppConstant.session);
                          if (!isLoggedIn) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginWithMobileScreen()),
                            );
                          } else {
                            if (isFav) {
                              final res = await favKitchenModel
                                  .removeKitchenHttp(widget.snapshot.kitchenId);
                              Utils.showToast(res!.message.toString());
                            } else {
                              final res = await favKitchenModel
                                  .favKitchenHttp(widget.snapshot.kitchenId);
                              Utils.showToast(res!.message.toString());
                            }

                            setState(() {
                              isFav = !isFav;
                            });
                          }
                        },
                        child: isFav
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Color(0xff2F3443),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 30,
                      child: widget.snapshot.averageRating != "0.0"
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 16),
                                  Text(
                                    widget.snapshot.averageRating,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppConstant.fontRegular,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ])
                          : SizedBox(),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 5,
                            offset: Offset(0, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(3),
                      child: widget.snapshot.kitchenType == "Diet&Home"
                          ? SvgPicture.asset(
                              'assets/images/home_diet.svg',
                              height: 20,
                            )
                          : widget.snapshot.kitchenType == "Home"
                              ? SvgPicture.asset(
                                  'assets/images/home_kitchen.svg',
                                  height: 20,
                                )
                              : widget.snapshot.kitchenType == "Diet"
                                  ? SvgPicture.asset(
                                      'assets/images/Diet_kitchen.svg',
                                      height: 20,
                                    )
                                  : SizedBox(),
                    ),
                    Text(
                      widget.snapshot.kitchenType,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          //8
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
