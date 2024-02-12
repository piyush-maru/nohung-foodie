import 'package:flutter/material.dart';
import 'package:food_app/presentation/screen/location_collections/search_address_screen.dart';
import 'package:food_app/presentation/screen/location_collections/widgets/add_edit_address_bottomsheet.dart';
import 'package:food_app/presentation/screen/location_collections/widgets/address_list_card.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/user/user_address_list.dart';
import '../../../network/location_screen/location_api_controller.dart';
import '../../../network/user/user_address_model.dart';
import '../../../providers/address_location_provider.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/pref_manager.dart';
import '../../widgets/buttons/login_button.dart';
import '../../widgets/rotating_icon/rotating_icon.dart';
import '../../widgets/shimmer_container.dart';
import '../landing/landing_screen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key, this.fromProfileScreen = false});

  final bool fromProfileScreen;

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  late Future<UserAddressList> addressListFuture;
  late Future<bool> isLoggedFuture;

  @override
  void initState() {
    super.initState();

    final addressModel = Provider.of<UserAddressModel>(context, listen: false);
    addressListFuture = addressModel.getUserAddress();
    isLoggedFuture = PrefManager.getBool(AppConstant.session);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return WillPopScope(
      onWillPop: () async {
        widget.fromProfileScreen
            ? Navigator.of(context).pop()
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LandingScreen()),
                (route) => false);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 4,
          // leadingWidth: 280,
          leading: InkWell(
              onTap: () {
                widget.fromProfileScreen
                    ? Navigator.of(context).pop()
                    : Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LandingScreen()),
                        (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Image.asset("assets/images/backyellowbutton.png",
                    height: 24),
              )),
          title: poppinsText(
              txt: 'Set Your Location', fontSize: 20, weight: FontWeight.w500),
          centerTitle: true,
          /* centerTitle: true,
          title: poppinsText(
              txt: 'Set Your Location', fontSize: 20, weight: FontWeight.w500),*/
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FutureBuilder<bool>(
                future: isLoggedFuture,
                builder: (BuildContext context, snapshot) {
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
                    if (snapshot.data!) {
                      final locationModel = Provider.of<FoodieLocationsModel>(
                          context,
                          listen: false);
                      final userAddressModel = Provider.of<UserAddressModel>(
                        context,
                      );
                      final locationAddressProvider =
                          Provider.of<AddressLocationProvider>(
                        context,
                      );
                      return Column(
                        children: [
                          SizedBox(
                            height: 13,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Color(0x2F344333)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: Color(0xAB404240),
                                ),
                                Expanded(
                                  child: TextField(
                                    readOnly: true,
                                    cursorColor: kYellowColor,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SearchAddressScreen(),
                                        ),
                                      );
                                    },
                                    decoration: const InputDecoration(
                                      hintText:
                                          "Search location, Area, Street name...",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xAB404240),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 2),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PlacePicker(
                                      initialPosition:
                                          const LatLng(17.4431103, 78.3869877),
                                      selectedPlaceWidgetBuilder: (_,
                                          selectedPlace,
                                          state,
                                          isSearchBarFocused) {
                                        return isSearchBarFocused
                                            ? SizedBox()
                                            : FloatingCard(
                                                bottomPosition: 0.0,
                                                leftPosition: 0.0,
                                                rightPosition: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      poppinsText(
                                                          txt:
                                                              'SELECT DELIVERY LOCATION',
                                                          fontSize: 12,
                                                          color:
                                                              Color(0x992F3443),
                                                          letterSpacing: 1,
                                                          weight:
                                                              FontWeight.w500),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      state ==
                                                              SearchingState
                                                                  .Searching
                                                          ? Shimmer.fromColors(
                                                              baseColor:
                                                                  const Color(
                                                                      0xf7f1efef),
                                                              highlightColor:
                                                                  Colors.white,
                                                              child:
                                                                  const ShimmerContainer(
                                                                height: 100,
                                                                width: double
                                                                    .infinity,
                                                              ),
                                                            )
                                                          : Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .pin_drop_outlined,
                                                                      color: Color(
                                                                          0xB2EA0000),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Expanded(
                                                                      child: poppinsText(
                                                                          txt: selectedPlace?.addressComponents?.first.longName ??
                                                                              "",
                                                                          fontSize:
                                                                              15,
                                                                          color: Color(
                                                                              0xE52F3443),
                                                                          letterSpacing:
                                                                              1,
                                                                          weight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          40.0),
                                                                  child: poppinsText(
                                                                      txt: selectedPlace?.formattedAddress ??
                                                                          "",
                                                                      fontSize:
                                                                          13,
                                                                      color: Color(
                                                                          0xE52F3443),
                                                                      maxLines:
                                                                          3,
                                                                      weight: FontWeight
                                                                          .w400),
                                                                ),
                                                                SizedBox(
                                                                  height: 9,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      addLocationBottomSheet(
                                                                        context:
                                                                            context,
                                                                        selectedPlace:
                                                                            selectedPlace!,
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              10),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration:
                                                                          ShapeDecoration(
                                                                        color: Color(
                                                                            0xFFFCC546),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(2)),
                                                                        shadows: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Color(0x26000000),
                                                                            blurRadius:
                                                                                3,
                                                                            offset:
                                                                                Offset(1, 0),
                                                                            spreadRadius:
                                                                                0,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      child: poppinsText(
                                                                          txt:
                                                                              'CONFIRM LOCATION',
                                                                          fontSize:
                                                                              15,
                                                                          color: Colors
                                                                              .white,
                                                                          weight:
                                                                              FontWeight.w500),
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
                                      apiKey: AppConstant.placesApiKey,
                                      hintText: "Find a place ...",
                                      searchingText: "Please wait ...",
                                      selectText: "Select place",
                                      outsideOfPickAreaText:
                                          "Place not in area",
                                      useCurrentLocation: true,
                                      selectInitialPosition: true,
                                      usePinPointingSearch: true,
                                      usePlaceDetailSearch: true,
                                      zoomGesturesEnabled: true,
                                      zoomControlsEnabled: false,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x26000000),
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            RotatingIcon(
                                              icon: Icon(
                                                Icons.my_location,
                                                color: Colors.red,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            poppinsText(
                                                txt: 'Use Current Location',
                                                fontSize: 15,
                                                color: Colors.red,
                                                weight: FontWeight.w500),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: poppinsText(
                                                  txt: locationAddressProvider
                                                          .getAddress.isNotEmpty
                                                      ? locationAddressProvider
                                                          .getAddress
                                                      : userAddressModel
                                                          .getAddress,
                                                  fontSize: 13,
                                                  maxLines: 3,
                                                  color: Colors.black,
                                                  weight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PlacePicker(
                                      initialPosition: const LatLng(17.4431103, 78.3869877),
                                      selectedPlaceWidgetBuilder: (_,
                                          selectedPlace,
                                          state,
                                          isSearchBarFocused) {
                                        return isSearchBarFocused
                                            ? SizedBox()
                                            : FloatingCard(
                                                bottomPosition: 0.0,
                                                leftPosition: 0.0,
                                                rightPosition: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15.0,
                                                      vertical: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      poppinsText(
                                                          txt:
                                                              'SELECT DELIVERY LOCATION',
                                                          fontSize: 12,
                                                          color:
                                                              Color(0x992F3443),
                                                          letterSpacing: 1,
                                                          weight:
                                                              FontWeight.w500),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      state == SearchingState.Searching
                                                          ? Shimmer.fromColors(
                                                              baseColor: const Color(0xf7f1efef),
                                                              highlightColor:
                                                                  Colors.white,
                                                              child:
                                                                  const ShimmerContainer(
                                                                height: 100,
                                                                width: double
                                                                    .infinity,
                                                              ),
                                                            )
                                                          : Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons.pin_drop_outlined,
                                                                      color: Color(0xB2EA0000),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Expanded(
                                                                      child: poppinsText(
                                                                          txt: selectedPlace?.addressComponents?.first.longName ??
                                                                              "",
                                                                          fontSize:
                                                                              15,
                                                                          color: const Color(
                                                                              0xE52F3443),
                                                                          letterSpacing:
                                                                              1,
                                                                          weight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          40.0),
                                                                  child: poppinsText(
                                                                      txt: selectedPlace?.formattedAddress ??
                                                                          "",
                                                                      fontSize:
                                                                          13,
                                                                      color: const Color(
                                                                          0xE52F3443),
                                                                      maxLines:
                                                                          3,
                                                                      weight: FontWeight
                                                                          .w400),
                                                                ),
                                                                const SizedBox(
                                                                  height: 9,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      addLocationBottomSheet(
                                                                        context:
                                                                            context,
                                                                        selectedPlace:
                                                                            selectedPlace!,
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              10),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration:
                                                                          ShapeDecoration(
                                                                        color: Color(
                                                                            0xFFFCC546),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(2)),
                                                                        shadows: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Color(0x26000000),
                                                                            blurRadius:
                                                                                3,
                                                                            offset:
                                                                                Offset(1, 0),
                                                                            spreadRadius:
                                                                                0,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      child: poppinsText(
                                                                          txt:
                                                                              'CONFIRM LOCATION',
                                                                          fontSize:
                                                                              15,
                                                                          color: Colors
                                                                              .white,
                                                                          weight:
                                                                              FontWeight.w500),
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
                                      apiKey: AppConstant.placesApiKey,
                                      hintText: "Find a place ...",
                                      searchingText: "Please wait ...",
                                      selectText: "Select place",
                                      outsideOfPickAreaText: "Place not in area",
                                      useCurrentLocation: true,
                                      selectInitialPosition: true,
                                      usePinPointingSearch: true,
                                      usePlaceDetailSearch: true,
                                      zoomGesturesEnabled: true,
                                      zoomControlsEnabled: false,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x26000000),
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                      "assets/icons/icon_add_location.png",
                                      width: 30),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  poppinsText(
                                      txt: 'Add Address',
                                      fontSize: 15,
                                      weight: FontWeight.w500),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: poppinsText(
                                txt: 'Your Saved Address',
                                fontSize: 17,
                                weight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FutureBuilder<UserAddressList?>(
                              future: addressListFuture,
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
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
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  if (!snapshot.data!.status) {
                                    return Column(
                                      children: [
                                        Image.asset(
                                          'assets/icons/icon_no saved_addresses.png',
                                          width: screenWidth * 0.7,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        poppinsText(
                                            txt: snapshot.data!.message,
                                            fontSize: 22,
                                            weight: FontWeight.w500),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        ...snapshot.data!.data.home.map(
                                          (UserLocationTypes e) =>
                                              AddressListCard(address: e),
                                        ),
                                        ...snapshot.data!.data.office.map(
                                          (UserLocationTypes e) =>
                                              AddressListCard(address: e),
                                        ),
                                        ...snapshot.data!.data.other.map(
                                          (UserLocationTypes e) =>
                                              AddressListCard(address: e),
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppConstant.appColor,
                                  ),
                                );
                              }),
                        ],
                      );
                    }
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 120,
                          ),
                          Image.asset(
                            'assets/icons/icon_no saved_addresses.png',
                            // width: screenWidth * 0.7,
                            // height: screenHeight * 0.3,
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          poppinsText(
                              txt: 'No Saved Address',
                              fontSize: 22,
                              weight: FontWeight.w600),
                          SizedBox(
                            height: 10,
                          ),
                          poppinsText(
                              txt: 'Login to add & save your address',
                              maxLines: 2,
                              fontSize: 16,
                              color: Color(0xCC2F3443),
                              weight: FontWeight.w500),
                          SizedBox(
                            height: 20,
                          ),
                          LoginButton(),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppConstant.appColor,
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
