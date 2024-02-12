import 'package:flutter/material.dart';
import 'package:food_app/presentation/screen/location_collections/address_list_screen.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../model/user/user_address_list.dart';
import '../../../../network/user/user_address_model.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../widgets/shimmer_container.dart';
import 'add_edit_address_bottomsheet.dart';

class AddressListCard extends StatelessWidget {
  const AddressListCard({
    required this.address,
    super.key,
  });
  final UserLocationTypes address;
  @override
  Widget build(BuildContext context) {
    final addressProvider =
        Provider.of<UserAddressModel>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(width: 1.5, color: kYellowColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 0.5,
                            ),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.apartment,
                            size: 12,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        poppinsText(
                            txt: address.addressType,
                            fontSize: 15,
                            weight: FontWeight.w500),
                        SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return PlacePicker(
                                    initialPosition: LatLng(
                                        double.parse(address.latitude),
                                        double.parse(address.longitude)),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0,
                                                        vertical: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            40.0),
                                                                child: poppinsText(
                                                                    txt: selectedPlace
                                                                            ?.formattedAddress ??
                                                                        "",
                                                                    fontSize:
                                                                        13,
                                                                    color: Color(
                                                                        0xE52F3443),
                                                                    maxLines: 3,
                                                                    weight:
                                                                        FontWeight
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
                                                                      isDefaultAddress:
                                                                          address
                                                                              .isDefault,
                                                                      isToEdit:
                                                                          true,
                                                                      addressId:
                                                                          address
                                                                              .id,
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
                                                                          offset: Offset(
                                                                              1,
                                                                              0),
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
                                    useCurrentLocation: false,
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
                          child: Text(
                            'Edit',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: kYellowColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                          onTap: () {
                            address.isDefault == "y"
                                ? showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          // Set rounded corners
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppConstant.appColor),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.white),
                                          // height: 300,
                                          padding: const EdgeInsets.only(
                                              top: 28,
                                              bottom: 10,
                                              left: 18,
                                              right: 18.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.warning_amber_outlined,
                                                  color: kYellowColor,
                                                  size: 85),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              poppinsText(
                                                  txt:
                                                      'Default Address can\'t be deleted.',
                                                  maxLines: 3,
                                                  fontSize: 16,
                                                  textAlign: TextAlign.center,
                                                  weight: FontWeight.w600),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              poppinsText(
                                                  txt:
                                                      'Make another address default then try to delete.',
                                                  maxLines: 3,
                                                  fontSize: 14,
                                                  textAlign: TextAlign.center,
                                                  weight: FontWeight.w500),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color(0xE52F3443)),
                                                ),
                                                child: const Text(
                                                  "Close",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(36.0),
                                          // Set rounded corners
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppConstant.appColor),
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              color: Colors.white),
                                          // height: 300,
                                          padding: const EdgeInsets.only(
                                              top: 28,
                                              bottom: 10,
                                              left: 28,
                                              right: 28.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/delete_address.png",
                                                width: 136,
                                                height: 133,
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              poppinsText(
                                                  txt:
                                                      'Are you sure you want to delete this saved Address?',
                                                  maxLines: 3,
                                                  fontSize: 14,
                                                  textAlign: TextAlign.center,
                                                  weight: FontWeight.w400),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.black),
                                                    ),
                                                    child: const Text(
                                                      "NO",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              AppConstant
                                                                  .fontRegular),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 22,
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      addressProvider
                                                          .deleteAddress(
                                                              address.id)
                                                          .then((value) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            backgroundColor:
                                                                AppConstant
                                                                    .appColor,
                                                            content: Text(
                                                              "Address Deleted",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      AppConstant
                                                                          .fontRegular),
                                                            ),
                                                          ),
                                                        );
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const AddressListScreen(),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(AppConstant
                                                                  .appColor),
                                                    ),
                                                    child: const Text(
                                                      "YES",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              AppConstant
                                                                  .fontRegular),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                          },
                          child: Text(
                            'Delete ',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: kYellowColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        poppinsText(
                            txt: 'Make Default',
                            fontSize: 13,
                            weight: FontWeight.w500),
                        Switch(
                          value: address.isDefault == "y",
                          onChanged: (value) {
                            address.isDefault == "n"
                                ? addressProvider
                                    .makeAddressDefault(address.id)
                                    .then((response) {
                                    if (response.statusCode == 200) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddressListScreen(),
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Address added as default",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Something went wrong",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          ),
                                        ),
                                      );
                                    }
                                  })
                                : "";
                          },
                          activeColor: kYellowColor,
                        )
                      ],
                    ),
                  )),
            ],
          ),
          poppinsText(
              txt: '${address.street}, ${address.landmark}, ${address.address}',
              fontSize: 11,
              color: Color(0xFF2F3443),
              maxLines: 3,
              weight: FontWeight.w400),
        ],
      ),
    );
  }
}
