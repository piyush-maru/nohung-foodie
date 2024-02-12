import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/user/user_address_list.dart';
import '../../../network/location_screen/location_repo.dart';
import '../../../network/user/user_address_model.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../widgets/shimmer_container.dart';
import '../location_collections/widgets/add_edit_address_bottomsheet.dart';

class UpdateOrderAddressScreen extends StatefulWidget {
  const UpdateOrderAddressScreen({super.key});

  @override
  State<UpdateOrderAddressScreen> createState() =>
      _UpdateOrderAddressScreenState();
}

class _UpdateOrderAddressScreenState extends State<UpdateOrderAddressScreen>
    with SingleTickerProviderStateMixin {
  String? deliveryAddress = "";

  bool isEdit = false;

  late TabController _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider =
        Provider.of<UserAddressModel>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return PlacePicker(
                  initialPosition: const LatLng(17.4431103, 78.3869877),
                  selectedPlaceWidgetBuilder:
                      (_, selectedPlace, state, isSearchBarFocused) {
                    return isSearchBarFocused
                        ? SizedBox()
                        : FloatingCard(
                            bottomPosition: 0.0,
                            leftPosition: 0.0,
                            rightPosition: 0.0,
                            borderRadius: BorderRadius.circular(12.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  poppinsText(
                                      txt: 'SELECT DELIVERY LOCATION',
                                      fontSize: 12,
                                      color: Color(0x992F3443),
                                      letterSpacing: 1,
                                      weight: FontWeight.w500),
                                  SizedBox(
                                    height: 5,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  child: poppinsText(
                                                      txt: selectedPlace
                                                              ?.addressComponents
                                                              ?.first
                                                              .longName ??
                                                          "",
                                                      fontSize: 15,
                                                      color: Color(0xE52F3443),
                                                      letterSpacing: 1,
                                                      weight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 40.0),
                                              child: poppinsText(
                                                  txt: selectedPlace
                                                          ?.formattedAddress ??
                                                      "",
                                                  fontSize: 13,
                                                  color: Color(0xE52F3443),
                                                  maxLines: 3,
                                                  weight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: 9,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await updateAndAddNewLocationBottomSheet(
                                                    context: context,
                                                    selectedPlace:
                                                        selectedPlace!,
                                                  ).then((value) {
                                                    final userLocationProvider =
                                                        Provider.of<
                                                                UserLocations>(
                                                            context,
                                                            listen: false);
                                                    final mostRecentSavedAddress =
                                                        userLocationProvider
                                                            .mostRecentSavedAddress;

                                                    Navigator.pop(context);
                                                    Navigator.pop(
                                                        context,
                                                        UserLocationTypes(
                                                            address:
                                                                mostRecentSavedAddress!
                                                                    .address,
                                                            addressType:
                                                                mostRecentSavedAddress
                                                                    .addressType,
                                                            landmark:
                                                                mostRecentSavedAddress
                                                                    .landmark,
                                                            street:
                                                                mostRecentSavedAddress
                                                                    .street,
                                                            latitude:
                                                                mostRecentSavedAddress
                                                                    .latitude,
                                                            longitude:
                                                                mostRecentSavedAddress
                                                                    .longitude,
                                                            id: mostRecentSavedAddress
                                                                .id,
                                                            isDefault:
                                                                mostRecentSavedAddress
                                                                    .isDefault));
                                                  });
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  alignment: Alignment.center,
                                                  decoration: ShapeDecoration(
                                                    color: Color(0xFFFCC546),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                    shadows: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x26000000),
                                                        blurRadius: 3,
                                                        offset: Offset(1, 0),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                  child: poppinsText(
                                                      txt: 'CONFIRM LOCATION',
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      weight: FontWeight.w500),
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
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kYellowColor,
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: poppinsText(
              txt: 'Add New Address',
              fontSize: 18,
              textAlign: TextAlign.center),
        ),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: FutureBuilder<UserAddressList?>(
            future: addressProvider.getUserAddress(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null
                  ? ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                              const Text(
                                "Select One location",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: AppConstant.fontRegular,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (snapshot.data!.data.home.isEmpty &&
                              snapshot.data!.data.office.isEmpty &&
                              snapshot.data!.data.other.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 30,
                              ),
                              child: Center(
                                child: Text(
                                  "No Address Found",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.semiBoldText.copyWith(
                                      color: Colors.black87, fontSize: 20),
                                ),
                              ),
                            ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.data.home.length,
                              itemBuilder: (context, index) {
                                final List<UserLocationTypes> homeAddressList =
                                    snapshot.data!.data.home;

                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(
                                        context,
                                        UserLocationTypes(
                                            address:
                                                homeAddressList[index].address,
                                            addressType: homeAddressList[index]
                                                .addressType,
                                            landmark:
                                                homeAddressList[index].landmark,
                                            street:
                                                homeAddressList[index].street,
                                            latitude:
                                                homeAddressList[index].latitude,
                                            longitude: homeAddressList[index]
                                                .longitude,
                                            id: homeAddressList[index].id,
                                            isDefault: homeAddressList[index]
                                                .isDefault));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 6, bottom: 12),
                                    margin: const EdgeInsets.only(bottom: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: AppConstant.appColor),
                                    ),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 14),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  AppConstant.appColor,
                                              child: SvgPicture.asset(
                                                "assets/images/awesome-home.svg",
                                                height: 15,
                                                width: 15,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    homeAddressList[index]
                                                        .addressType
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontFamily: AppConstant
                                                            .fontBold),
                                                  ),
                                                  Text(
                                                    "${homeAddressList[index].street}, ${homeAddressList[index].landmark}, ${homeAddressList[index].address}",
                                                    style: const TextStyle(
                                                        fontFamily: AppConstant
                                                            .fontRegular,
                                                        fontSize: 12),
                                                  )
                                                ]),
                                          )
                                        ]),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.data.office.length,
                              itemBuilder: (context, index) {
                                final List<UserLocationTypes>
                                    officeAddressList =
                                    snapshot.data!.data.office;

                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(
                                        context,
                                        UserLocationTypes(
                                            address: officeAddressList[index]
                                                .address,
                                            addressType:
                                                officeAddressList[index]
                                                    .addressType,
                                            landmark: officeAddressList[index]
                                                .landmark,
                                            street:
                                                officeAddressList[index].street,
                                            latitude: officeAddressList[index]
                                                .latitude,
                                            longitude: officeAddressList[index]
                                                .longitude,
                                            id: officeAddressList[index].id,
                                            isDefault: officeAddressList[index]
                                                .isDefault));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 6, bottom: 12),
                                    margin: const EdgeInsets.only(bottom: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: AppConstant.appColor),
                                    ),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 14),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  AppConstant.appColor,
                                              child: SvgPicture.asset(
                                                "assets/images/awesome-home.svg",
                                                height: 15,
                                                width: 15,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    officeAddressList[index]
                                                        .addressType
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontFamily: AppConstant
                                                            .fontBold),
                                                  ),
                                                  Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 250,
                                                            maxHeight: 50),
                                                    child: Text(
                                                      "${officeAddressList[index].street}, ${officeAddressList[index].landmark}, ${officeAddressList[index].address}",
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              AppConstant
                                                                  .fontRegular,
                                                          fontSize: 12),
                                                    ),
                                                  )
                                                ]),
                                          )
                                        ]),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.data.other.length,
                              itemBuilder: (context, index) {
                                final List<UserLocationTypes> otherAddressList =
                                    snapshot.data!.data.other;

                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(
                                        context,
                                        UserLocationTypes(
                                            address:
                                                otherAddressList[index].address,
                                            addressType: otherAddressList[index]
                                                .addressType,
                                            landmark: otherAddressList[index]
                                                .landmark,
                                            street:
                                                otherAddressList[index].street,
                                            latitude: otherAddressList[index]
                                                .latitude,
                                            longitude: otherAddressList[index]
                                                .longitude,
                                            id: otherAddressList[index].id,
                                            isDefault: otherAddressList[index]
                                                .isDefault));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 6, bottom: 12),
                                    margin: const EdgeInsets.only(bottom: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: AppConstant.appColor),
                                    ),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 14),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  AppConstant.appColor,
                                              child: SvgPicture.asset(
                                                "assets/images/awesome-home.svg",
                                                height: 15,
                                                width: 15,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    otherAddressList[index]
                                                        .addressType
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontFamily: AppConstant
                                                            .fontBold),
                                                  ),
                                                  Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 250,
                                                            maxHeight: 50),
                                                    child: Text(
                                                      "${otherAddressList[index].street}, ${otherAddressList[index].landmark}, ${otherAddressList[index].address}",
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              AppConstant
                                                                  .fontRegular,
                                                          fontSize: 12),
                                                    ),
                                                  )
                                                ]),
                                          )
                                        ]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ])
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppConstant.appColor,
                      ),
                    );
            }),
      ),
    );
  }
}
