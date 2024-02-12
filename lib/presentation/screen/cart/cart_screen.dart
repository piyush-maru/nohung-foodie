import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_app/presentation/screen/Cart/schedule_preferred_date_time_container.dart';
import 'package:food_app/presentation/screen/cart/change_address_screen.dart';
import 'package:food_app/presentation/screen/cart/widgets/bill_details_section.dart';
import 'package:food_app/presentation/screen/cart/widgets/cart_item_card.dart';
import 'package:food_app/presentation/screen/landing/landing_screen.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/helper_class.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/address/default_address.dart';
import '../../../model/cart_count_provider/cart_count_provider.dart';
import '../../../model/cart_screen_class/cart_screen_model_class.dart';
import '../../../model/login.dart';
import '../../../model/offers_screen/offers_list_model.dart';
import '../../../model/user/user_address_list.dart';
import '../../../network/cart_repo/cart_screen_model.dart';
import '../../../network/kitchen_details/kitchen_details_controller.dart';
import '../../../network/pre_order/pre_order_provider.dart';
import '../../../network/selectDateTime/GetOfflineDatesModel.dart';
import '../../../network/user/user_address_model.dart';
import '../../../utils/Utils.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../../utils/size_config.dart';
import '../../widgets/buttons/login_button.dart';
import '../../widgets/shimmer_container.dart';
import '../../widgets/text_field/custom'
    '_text_field.dart';
import '../all_offers/all_offers_screen.dart';
import '../kitchen_details/kitchen_details_screen.dart';
import '../location_collections/widgets/add_edit_address_bottomsheet.dart';

class CartScreen extends StatefulWidget {
  final bool isFromPreOrderFlow;
  const CartScreen({
    super.key,
    this.isFromPreOrderFlow = false,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late UserAddressListData addressList;

  String selectedAddress = "";

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  late final kitchenID;
  int selectedRadioTile = 0;
  final instructionsController = TextEditingController();

  final applyPromoController = TextEditingController();

  bool isWalletActive = true;

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  void loadAddresses() async {
    final addressProvider =
        Provider.of<UserAddressModel>(context, listen: false);
    final data = await addressProvider.getUserAddress();
    addressList = data.data;
  }

  checkIsKitchenCloseToday() async {
    final preOrderProvider =
        Provider.of<PreorderProvider>(context, listen: false);
    final cartCountProvider =
        Provider.of<CartCountModel>(context, listen: false);
    final cartProvider = Provider.of<CartScreenModel>(context, listen: false);
    final cartModel = await cartProvider.getCartDetails();
    if (cartModel.status == "false") {
      return;
    } else {
      cartCountProvider.checkCartCount(provider: preOrderProvider);

      kitchenID = cartModel.data.kitchenDetailData.kitchenId;

      if (cartModel.data.pre_order_delivery_date != null &&
          cartModel.data.pre_order_delivery_date!.isNotEmpty) {
        preOrderProvider.updateTime(
            '${Helper.formatTime(cartModel.data.pre_order_delivery_fromtime!)}-${Helper.formatTime(cartModel.data.pre_order_delivery_totime!)}');
        preOrderProvider.updateTimeFinal(
            '${Helper.formatTime(cartModel.data.pre_order_delivery_fromtime!)}-${Helper.formatTime(cartModel.data.pre_order_delivery_totime!)}');
        preOrderProvider.updateDate(Helper.formatDateFromString(
            cartModel.data.pre_order_delivery_date!));
        preOrderProvider.updateUnformattedDate(Helper.formatDateFromString(
            cartModel.data.pre_order_delivery_date!));
      }

      final offlineProvider =
          Provider.of<GetOfflineDatesModel>(context, listen: false);

      final isKitchenCloseModel =
          await offlineProvider.getOfflineDates(kitchenID!);

      final offlineDatesList = isKitchenCloseModel.data
          .map((offlineDate) =>
              DateFormat('yyyy-MM-dd').format(offlineDate.date))
          .toList();

      final isKitchenClose = offlineDatesList
          .contains(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      preOrderProvider.updateIsKitchenOffline(isKitchenClose);
      if (widget.isFromPreOrderFlow) {
        SchedulerBinding.instance.addPostFrameCallback(
          (_) async => await showDialog<void>(
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.7),
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                insetAnimationDuration: const Duration(seconds: 1),
                insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  // Set rounded corners
                ),
                child: isKitchenClose
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                                'assets/images/image_kitchen_closed.png',
                                fit: BoxFit.contain,
                                height: SizeConfig.screenWidth! * 0.55),
                            const SizedBox(
                              height: 15,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Please schedule your preferred ',
                                style: AppTextStyles.titleText.copyWith(
                                    color: Colors.black, fontSize: 16),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Date ',
                                    style: AppTextStyles.titleText.copyWith(
                                        color: const Color(0xFFEA0000),
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: '&',
                                    style: AppTextStyles.titleText.copyWith(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: ' Time',
                                    style: AppTextStyles.titleText.copyWith(
                                        color: const Color(0xFFEA0000),
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFCC647),
                                    borderRadius: BorderRadius.circular(6)),
                                child: const Text(
                                  "Okay",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ScheduleDateTimeContainer(
                        // firstPreOrderDates: preOrderDates.first,
                        // firstPreOrderTimes: preOrderTimes.first,
                        kitchenID: kitchenID,
                        isFromDialog: true,
                      ),
              );
            },
          ),
        );
      }
    }
  }

  late Future<UserPersonalInfo> getUserFuture;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkIsKitchenCloseToday();
    });
    loadAddresses();
    getUserFuture = Utils.getUser();
  }

  @override
  void dispose() {
    super.dispose();
    applyPromoController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    instructionsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    final kitchenDetailsProvider =
        Provider.of<KitchenDetailsModel>(context, listen: false);
    // final walletProvider = Provider.of<WalletProvider>(context, listen: true);
    final addressProvider =
        Provider.of<UserAddressModel>(context, listen: true);
    final cartProvider = Provider.of<CartScreenModel>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LandingScreen()),
            (route) => false);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFFB200),
          leadingWidth: 100,
          leading: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingScreen()),
                      (route) => false);
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
                  txt: "Cart",
                  fontSize: 20,
                  weight: FontWeight.w600,
                  color: Colors.black),
            ],
          ),
        ),
        body: FutureBuilder<GetCartDetailsModel>(
          future: cartProvider.getCartDetails(),
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
              final data = snapshot.data!.data;
              if (snapshot.data!.message == "Login is mandatory.") {
                return Center(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/icon_cart_not_logged_in.png',
                        // controller: _animationController,

                        height: screenHeight * 0.3,
                      ),
                      poppinsText(
                        txt: 'Your Cart is empty',
                        fontSize: 26,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        weight: FontWeight.w600,
                      ),
                      poppinsText(
                          txt: 'Login to Order from your favourite kitchens',
                          fontSize: 17,
                          textAlign: TextAlign.center,
                          weight: FontWeight.w500,
                          maxLines: 3),
                      SizedBox(
                        height: 20,
                      ),
                      LoginButton()
                    ],
                  ),
                ));
              }

              if (snapshot.data!.data.cartItems.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/icon_cart_not_logged_in.png',
                          // controller: _animationController,

                          height: screenHeight * 0.3,
                        ),
                        poppinsText(
                          txt: 'Your Cart is empty',
                          fontSize: 26,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          weight: FontWeight.w600,
                        ),
                        poppinsText(
                            txt:
                                'Looks like you haven’t added anything to your cart yet',
                            fontSize: 17,
                            textAlign: TextAlign.center,
                            weight: FontWeight.w500,
                            maxLines: 3),
                        SizedBox(
                          height: 20,
                        ),
                        InkResponse(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LandingScreen(),
                                ),
                                (route) => false);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: ShapeDecoration(
                              color: kYellowColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Text(
                              "Browse Kitchens",
                              style: AppTextStyles.titleText.copyWith(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      poppinsText(
                          txt: "Your Order Summary",
                          fontSize: 20,
                          weight: FontWeight.w400),
                      Text(
                        data.kitchenDetailData.kitchenName ?? "",
                        style:
                            AppTextStyles.semiBoldText.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (data.cartItems.first.isTrial)
                        ScheduleDateTimeContainer(
                          kitchenID: snapshot
                              .data!.data.kitchenDetailData.kitchenId
                              .toString(),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      CartItemCard(cartProvider: cartProvider),
                      const SizedBox(
                        height: 15,
                      ),
                      if (data.cartItems.first.isTrial)
                        Align(
                          alignment: Alignment.center,
                          child: InkResponse(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => KitchenDetailsScreen(
                                      snapshot.data!.data!.kitchenDetailData
                                          .kitchenId!,
                                      OrderCategory.Subscription.toJsonKey(),
                                      initialIndex: 1),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: kYellowColor),
                              child: Text(
                                "ADD MORE",
                                style: AppTextStyles.titleText.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (data.cartItems.first.isTrial)
                        const SizedBox(
                          height: 15,
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 10,
                              offset: Offset(4, 5),
                              spreadRadius: 0,
                            )
                          ],
                          border: Border.all(color: Colors.black26, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ordering For",
                              style: AppTextStyles.normalText.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppConstant.appColor,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<UserPersonalInfo>(
                                future: getUserFuture,
                                builder: (context, userSnapshot) {
                                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: AppConstant.appColor,
                                      ),
                                    );
                                  }
                                  if (userSnapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        userSnapshot.error.toString(),
                                      ),
                                    );
                                  }
                                  if (userSnapshot.connectionState ==
                                          ConnectionState.done &&
                                      userSnapshot.hasData) {
                                    if (nameController.text.isEmpty ||
                                        phoneNumberController.text.isEmpty) {
                                      nameController.text =
                                          userSnapshot.data!.username!;
                                      phoneNumberController.text =
                                          userSnapshot.data!.mobilenumber!;
                                    }
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            // nameController.text.isEmpty
                                            //     ? "${userSnapshot.data?.username}, ${userSnapshot.data?.mobilenumber}"
                                            //     :
                                            "${nameController.text}, ${phoneNumberController.text}",
                                            style: AppTextStyles.normalText
                                                .copyWith(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        InkResponse(
                                          onTap: () {
                                            showDialog(
                                                barrierDismissible: true,
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: Colors.white),
                                                      // height: 300,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 7.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10.0,
                                                                    right: 5),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Ordering For Detail",
                                                                    style: AppTextStyles
                                                                        .normalText
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          17,
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .close),
                                                                  )
                                                                ]),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Name",
                                                                    style: AppTextStyles
                                                                        .normalText
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                  CustomTextField(
                                                                    controller:
                                                                        nameController,
                                                                    hint:
                                                                        "Your Name",
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          15),
                                                                  Text(
                                                                    "Phone Number",
                                                                    style: AppTextStyles
                                                                        .normalText
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                  CustomTextField(
                                                                    controller:
                                                                        phoneNumberController,
                                                                    hint:
                                                                        "Your Number",
                                                                    textInputType:
                                                                        TextInputType
                                                                            .phone,
                                                                    maxChar: 10,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          15),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            kYellowColor,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {});
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Update",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "Change",
                                                style: AppTextStyles.normalText
                                                    .copyWith(
                                                  color: kYellowColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.edit,
                                                color: kYellowColor,
                                                size: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppConstant.appColor,
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Delivery Location",
                              style: AppTextStyles.normalText.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: AppConstant.appColor,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            FutureBuilder<DefaultAddress>(
                                future: addressProvider.getDefaultAddress(),
                                builder: (context, snap) {
                                  if (snap.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: AppConstant.appColor,
                                      ),
                                    );
                                  }
                                  if (snap.hasError) {
                                    return Center(
                                      child: Text(
                                        snap.error.toString(),
                                      ),
                                    );
                                  }
                                  if (snap.connectionState ==
                                          ConnectionState.done &&
                                      snap.hasData) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        (snap.data!.data.isEmpty)
                                            ? Text(
                                                "Address not found",
                                                style: AppTextStyles.normalText
                                                    .copyWith(
                                                  color: Color(0xB22F3443),
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 14,
                                                ),
                                              )
                                            : Expanded(
                                                child: Text(
                                                  "${snap.data?.data.first.street}, ${snap.data?.data.first.landmark}, ${snap.data?.data.first.address}",
                                                  style: AppTextStyles
                                                      .normalText
                                                      .copyWith(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        InkResponse(
                                          onTap: () async {
                                            (snap.data!.data.isEmpty)
                                                ? await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                          context) {
                                                        return PlacePicker(
                                                          initialPosition:
                                                              const LatLng(
                                                                  17.4431103,
                                                                  78.3869877),
                                                          selectedPlaceWidgetBuilder: (_,
                                                              selectedPlace,
                                                              state,
                                                              isSearchBarFocused) {
                                                            return isSearchBarFocused
                                                                ? SizedBox()
                                                                : FloatingCard(
                                                                    bottomPosition:
                                                                        0.0,
                                                                    leftPosition:
                                                                        0.0,
                                                                    rightPosition:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              15.0,
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          poppinsText(
                                                                              txt: 'SELECT DELIVERY LOCATION',
                                                                              fontSize: 12,
                                                                              color: Color(0x992F3443),
                                                                              letterSpacing: 1,
                                                                              weight: FontWeight.w500),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          state == SearchingState.Searching
                                                                              ? Shimmer.fromColors(
                                                                                  baseColor: const Color(0xf7f1efef),
                                                                                  highlightColor: Colors.white,
                                                                                  child: const ShimmerContainer(
                                                                                    height: 100,
                                                                                    width: double.infinity,
                                                                                  ),
                                                                                )
                                                                              : Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.pin_drop_outlined,
                                                                                          color: Color(0xB2EA0000),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: poppinsText(txt: selectedPlace?.addressComponents?.first.longName ?? "", fontSize: 15, color: Color(0xE52F3443), letterSpacing: 1, weight: FontWeight.w600),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(right: 40.0),
                                                                                      child: poppinsText(txt: selectedPlace?.formattedAddress ?? "", fontSize: 13, color: Color(0xE52F3443), maxLines: 3, weight: FontWeight.w400),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 9,
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          addLocationBottomSheet(context: context, selectedPlace: selectedPlace!, isFromCartAddNew: true);
                                                                                        },
                                                                                        child: Container(
                                                                                          width: double.infinity,
                                                                                          padding: EdgeInsets.symmetric(vertical: 10),
                                                                                          alignment: Alignment.center,
                                                                                          decoration: ShapeDecoration(
                                                                                            color: Color(0xFFFCC546),
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                                                                            shadows: [
                                                                                              BoxShadow(
                                                                                                color: Color(0x26000000),
                                                                                                blurRadius: 3,
                                                                                                offset: Offset(1, 0),
                                                                                                spreadRadius: 0,
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                          child: poppinsText(txt: 'CONFIRM LOCATION', fontSize: 15, color: Colors.white, weight: FontWeight.w500),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                          },
                                                          apiKey: AppConstant
                                                              .placesApiKey,
                                                          hintText:
                                                              "Find a place ...",
                                                          searchingText:
                                                              "Please wait ...",
                                                          selectText:
                                                              "Select place",
                                                          outsideOfPickAreaText:
                                                              "Place not in area",
                                                          useCurrentLocation:
                                                              true,
                                                          selectInitialPosition:
                                                              true,
                                                          usePinPointingSearch:
                                                              true,
                                                          usePlaceDetailSearch:
                                                              true,
                                                          zoomGesturesEnabled:
                                                              true,
                                                          zoomControlsEnabled:
                                                              false,
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChangeAddress(
                                                                addressList:
                                                                    addressList,
                                                                selectedAddressID: snap
                                                                        .data
                                                                        ?.data
                                                                        .first
                                                                        .id ??
                                                                    "")),
                                                  );
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                (snap.data!.data.isEmpty)
                                                    ? "Add Address"
                                                    : "Change",
                                                style: AppTextStyles.normalText
                                                    .copyWith(
                                                  color: kYellowColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              if (!snap.data!.data.isEmpty)
                                                const Icon(
                                                  Icons.edit,
                                                  color: kYellowColor,
                                                  size: 15,
                                                )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppConstant.appColor,
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 2),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: const Color(0x66FCC647),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  trailing: Icon(
                                    Icons.add_circle,
                                    size: 30,
                                    color: Color(0xff6d6a65),
                                  ),
                                  // childrenPadding:
                                  //     const EdgeInsets.symmetric(horizontal: 3),
                                  iconColor: Colors.black,
                                  title: FittedBox(
                                    child: poppinsText(
                                        txt:
                                            "Add special instructions for the kitchen",
                                        fontSize: 14,
                                        weight: FontWeight.w500,
                                        color: Color(0xB22F3443),
                                        maxLines: 1),
                                  ),
                                  children: <Widget>[
                                    CustomTextField(
                                      maxLines: 4,
                                      onChanged: (String value) {
                                        cartProvider.updateDeliveryInstruction(
                                            value.trim());
                                      },
                                      textInputType: TextInputType.multiline,
                                      hint: "Add instructions here... ",
                                      controller: instructionsController,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      cursorColor: AppConstant.appColor,
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                      controller: applyPromoController,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.sell,
                                          color: Colors.black87,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color:
                                                  kYellowColor), //<-- SEE HERE
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kYellowColor, width: 1.0),
                                          // borderRadius: BorderRadius.circular(25.0),
                                        ),
                                        hintText: "Apply Coupon",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400),
                                        prefixStyle: const TextStyle(
                                            color: Colors.transparent),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final res =
                                          await cartProvider.applyCouponCode(
                                              couponCode: applyPromoController
                                                  .text
                                                  .trim(),
                                              kitchenID: data.kitchenDetailData
                                                      .kitchenId ??
                                                  "");
                                      if (res.status) {
                                        setState(() {});
                                        cartProvider.updateCouponCode(
                                            applyPromoController.text.trim());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor:
                                                AppConstant.appColor,
                                            content: Text(
                                              res.message,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                          ),
                                        );
                                      } else if (!res.status) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text(
                                              res.message,
                                              style: const TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.black87,
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FutureBuilder<OffersList>(
                                future: kitchenDetailsProvider.getOfferList(
                                  kitchenId:
                                      data.kitchenDetailData.kitchenId ?? "",
                                ),
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
                                    return InkResponse(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AllOffersScreen(
                                              kitchenID: data.kitchenDetailData
                                                      .kitchenId ??
                                                  "",
                                            ),
                                          ),
                                        ).then((value) => setState(() {}));
                                      },
                                      child: Text(
                                        "View Offers",
                                        style:
                                            AppTextStyles.normalText.copyWith(
                                          color: AppConstant.appColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppConstant.appColor,
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 7,
                            ),
                            BillDetailsSection(
                                subTotal: data.subTotal,
                                walletBalance: data.walletBalance,
                                name: nameController.text.trim(),
                                number: phoneNumberController.text.trim(),
                                cartProvider: cartProvider)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: AppConstant.appColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
