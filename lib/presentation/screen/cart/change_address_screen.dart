import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/cart_screen_class/cart_screen_model_class.dart';
import '../../../model/user/user_address_list.dart';
import '../../../network/cart_repo/cart_screen_model.dart';
import '../../../network/user/user_address_model.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../widgets/shimmer_container.dart';
import '../location_collections/widgets/add_edit_address_bottomsheet.dart';

class ChangeAddress extends StatefulWidget {
  final UserAddressListData addressList;
  final String selectedAddressID;
  const ChangeAddress({
    super.key,
    required this.addressList,
    required this.selectedAddressID,
  });

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  bool _isSatSelected = true;
  String? radioGroupValue;

  @override
  void initState() {
    super.initState();
    radioGroupValue = widget.selectedAddressID;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartScreenModel>(context, listen: true);
    final addressProvider =
        Provider.of<UserAddressModel>(context, listen: false);
    //UserAddressListData? addressList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        leadingWidth: 40,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SvgPicture.asset(
              'assets/images/backbuttin_y.svg',
              height: 20,
              width: 20,
            ),
          ),
        ),
        title: poppinsText(
            txt: "Change delivery address",
            maxLines: 3,
            fontSize: 20,
            textAlign: TextAlign.center,
            weight: FontWeight.w500),
      ),
      body: FutureBuilder<GetCartDetailsModel>(
          future: cartProvider.getCartDetails(),
          builder: (context, snapshot) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    widget.addressList!.home!.isEmpty &&
                            widget.addressList!.office!.isEmpty &&
                            widget.addressList.other.isEmpty
                        ? Text(
                            "No Address Found",
                            style: AppTextStyles.normalText.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (UserLocationTypes address
                                  in widget.addressList.home)
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<String>(
                                        activeColor: kYellowColor,
                                        contentPadding: EdgeInsets.zero,
                                        dense: false,
                                        visualDensity: VisualDensity.compact,
                                        value: address.id,
                                        groupValue: radioGroupValue,
                                        onChanged: (val) async {
                                          radioGroupValue = val;
                                          setState(() {});
                                          if (radioGroupValue == null) {
                                            return;
                                          }
                                          await addressProvider
                                              .makeAddressDefault(
                                                  radioGroupValue!)
                                              .then((value) =>
                                                  Navigator.pop(context));
                                        },
                                        title: Text(
                                            "${address.street}, ${address.landmark}, ${address.address}"),
                                        toggleable: true,
                                        selected: radioGroupValue == address.id,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return PlacePicker(
                                                initialPosition: LatLng(
                                                    double.parse(
                                                        address.latitude),
                                                    double.parse(
                                                        address.longitude)),
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
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15.0,
                                                                    vertical:
                                                                        15),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                poppinsText(
                                                                    txt:
                                                                        'SELECT DELIVERY LOCATION',
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0x992F3443),
                                                                    letterSpacing:
                                                                        1,
                                                                    weight:
                                                                        FontWeight
                                                                            .w500),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                state ==
                                                                        SearchingState
                                                                            .Searching
                                                                    ? Shimmer
                                                                        .fromColors(
                                                                        baseColor:
                                                                            const Color(0xf7f1efef),
                                                                        highlightColor:
                                                                            Colors.white,
                                                                        child:
                                                                            const ShimmerContainer(
                                                                          height:
                                                                              100,
                                                                          width:
                                                                              double.infinity,
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
                                                                                child: poppinsText(txt: selectedPlace?.addressComponents?.first.longName ?? "", fontSize: 15, color: Color(0xE52F3443), letterSpacing: 1, weight: FontWeight.w600),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 40.0),
                                                                            child: poppinsText(
                                                                                txt: selectedPlace?.formattedAddress ?? "",
                                                                                fontSize: 13,
                                                                                color: Color(0xE52F3443),
                                                                                maxLines: 3,
                                                                                weight: FontWeight.w400),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                9,
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                addLocationBottomSheet(isToEdit: true, isFromCartEdit: true, addressId: address.id, context: context, selectedPlace: selectedPlace!, isDefaultAddress: address.isDefault);
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
                                                apiKey:
                                                    AppConstant.placesApiKey,
                                                hintText: "Find a place ...",
                                                searchingText:
                                                    "Please wait ...",
                                                selectText: "Select place",
                                                outsideOfPickAreaText:
                                                    "Place not in area",
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
                                      child: Row(
                                        children: [
                                          poppinsText(
                                              txt: 'Edit  ',
                                              color: AppConstant.appColor,
                                              fontSize: 15),
                                          Icon(
                                            Icons.edit,
                                            color: kYellowColor,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              for (var address in widget.addressList.office)
                                Row(
                                  children: [
                                    RadioListTile<String>(
                                      activeColor: kYellowColor,
                                      contentPadding: EdgeInsets.zero,
                                      dense: false,
                                      visualDensity: VisualDensity.compact,
                                      value: address.id,
                                      groupValue: radioGroupValue,
                                      onChanged: (val) async {
                                        radioGroupValue = val;

                                        setState(() {});
                                        if (radioGroupValue == null) {
                                          return;
                                        }
                                        await addressProvider
                                            .makeAddressDefault(
                                                radioGroupValue!)
                                            .then((value) =>
                                                Navigator.pop(context));
                                      },
                                      title: Text(
                                          "${address.street}, ${address.landmark}, ${address.address}"),
                                      toggleable: true,
                                      selected: radioGroupValue == address.id,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          poppinsText(
                                              txt: 'Edit  ', fontSize: 15),
                                          Icon(
                                            Icons.edit,
                                            color: kYellowColor,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              for (var address in widget.addressList.other)
                                Row(
                                  children: [
                                    RadioListTile<String>(
                                      activeColor: kYellowColor,
                                      contentPadding: EdgeInsets.zero,
                                      value: address.id,
                                      dense: false,
                                      visualDensity: VisualDensity.compact,
                                      groupValue: radioGroupValue,
                                      onChanged: (val) async {
                                        radioGroupValue = val;

                                        setState(() {});

                                        if (radioGroupValue == null) {
                                          return;
                                        }
                                        await addressProvider
                                            .makeAddressDefault(
                                                radioGroupValue!)
                                            .then((value) =>
                                                Navigator.pop(context));
                                        addressProvider.makeAddressDefault(
                                            radioGroupValue!);

                                        Navigator.pop(context);
                                      },
                                      title: Text(
                                          "${address.street}, ${address.landmark}, ${address.address}"),
                                      toggleable: true,
                                      selected: radioGroupValue == address.id,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          poppinsText(
                                              txt: 'Edit  ', fontSize: 15),
                                          Icon(
                                            Icons.edit,
                                            color: kYellowColor,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              const SizedBox(height: 16),
                              Center(
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return PlacePicker(
                                            initialPosition: const LatLng(
                                                17.4431103, 78.3869877),
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
                                                          BorderRadius.circular(
                                                              12.0),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    15.0,
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
                                                                color: Color(
                                                                    0x992F3443),
                                                                letterSpacing:
                                                                    1,
                                                                weight:
                                                                    FontWeight
                                                                        .w500),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            state ==
                                                                    SearchingState
                                                                        .Searching
                                                                ? Shimmer
                                                                    .fromColors(
                                                                    baseColor:
                                                                        const Color(
                                                                            0xf7f1efef),
                                                                    highlightColor:
                                                                        Colors
                                                                            .white,
                                                                    child:
                                                                        const ShimmerContainer(
                                                                      height:
                                                                          100,
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
                                                                            Icons.pin_drop_outlined,
                                                                            color:
                                                                                Color(0xB2EA0000),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Expanded(
                                                                            child: poppinsText(
                                                                                txt: selectedPlace?.addressComponents?.first.longName ?? "",
                                                                                fontSize: 15,
                                                                                color: Color(0xE52F3443),
                                                                                letterSpacing: 1,
                                                                                weight: FontWeight.w600),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
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
                                                                            weight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            9,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            addLocationBottomSheet(
                                                                                context: context,
                                                                                selectedPlace: selectedPlace!,
                                                                                isFromCartAddNew: true);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: 10),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                ShapeDecoration(
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
                                    width: 130,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: kYellowColor,
                                    ),
                                    child: Center(
                                      child: poppinsText(
                                          txt: "Add Address",
                                          maxLines: 3,
                                          fontSize: 13,
                                          textAlign: TextAlign.center,
                                          weight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
