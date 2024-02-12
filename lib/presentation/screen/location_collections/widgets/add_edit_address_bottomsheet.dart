import 'package:flutter/material.dart';
import 'package:food_app/presentation/screen/Cart/cart_screen.dart';
import 'package:food_app/utils/size_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:provider/provider.dart';

import '../../../../model/user/user_address_list.dart';
import '../../../../network/location_screen/location_repo.dart';
import '../../../../utils/Utils.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/asset_constants.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../widgets/rotating_icon/rotating_icon.dart';
import '../address_list_screen.dart';

Future<void> addLocationBottomSheet(
    {required BuildContext context,
    required PickResult selectedPlace,
    bool isToEdit = false,
    String? isDefaultAddress,
    bool isFromCartAddNew = false,
    bool isFromCartEdit = false,
    String? addressId}) {
  bool isDefault = true;
  final streetController = TextEditingController();
  final landMarkController = TextEditingController();

  final addressProvider = Provider.of<UserLocations>(context, listen: false);

  return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter mystate) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xdba7a5a5)),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            RotatingIcon(
                              icon: const Icon(
                                Icons.my_location,
                                color: Colors.red,
                              ),
                            ),
                            VerticalDivider(
                              color: Color(0xffA7A5A5),
                            ),
                            Expanded(
                                child: poppinsText(
                              txt: selectedPlace.formattedAddress ?? "",
                              maxLines: 3,
                              color: Color(0xFF8F8F8F),
                              weight: FontWeight.w400,
                              fontSize: 12,
                            )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      cursorColor: kYellowColor,
                      decoration: InputDecoration(
                        hintText: "Type Door/ Flat No, Street, etc..",
                        hintStyle: const TextStyle(
                            fontFamily: AppConstant.fontRegular),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 3,
                            style: BorderStyle.none,
                            color: Color(0xdba7a5a5),
                          ),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xdba7a5a5)),
                        ),
                      ),
                      controller: streetController,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      cursorColor: kYellowColor,
                      decoration: InputDecoration(
                        hintText: "Landmark",
                        hintStyle: const TextStyle(
                            fontFamily: AppConstant.fontRegular),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              width: 3,
                              style: BorderStyle.none,
                              color: Color(0xdba7a5a5)),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xdba7a5a5)),
                        ),
                      ),
                      controller: landMarkController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkResponse(
                            onTap: () {
                              addressProvider.updateAddressType("Home");

                              mystate(() {});
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 19,
                                  width: 19,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: addressProvider.addressType ==
                                                  "Home"
                                              ? kYellowColor
                                              : Color(0xffA8A7A7),
                                          width: 1)),
                                  child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: addressProvider.addressType ==
                                                "Home"
                                            ? kYellowColor
                                            : Colors.white,
                                      )),
                                ),
                                const Text(
                                  "  Home",
                                  style: TextStyle(
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 36,
                        ),
                        InkResponse(
                            onTap: () {
                              addressProvider.updateAddressType("Office");

                              mystate(() {});
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 19,
                                  width: 19,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: addressProvider.addressType ==
                                                  "Office"
                                              ? kYellowColor
                                              : Color(0xffA8A7A7),
                                          width: 1)),
                                  child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: addressProvider.addressType ==
                                                "Office"
                                            ? kYellowColor
                                            : Colors.white,
                                      )),
                                ),
                                const Text(
                                  "  Office",
                                  style: TextStyle(
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 36,
                        ),
                        InkResponse(
                            onTap: () {
                              addressProvider.updateAddressType("Other");

                              mystate(() {});
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 19,
                                  width: 19,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: addressProvider.addressType ==
                                                  "Other"
                                              ? kYellowColor
                                              : Color(0xffA8A7A7),
                                          width: 1)),
                                  child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: addressProvider.addressType ==
                                                "Other"
                                            ? kYellowColor
                                            : Colors.white,
                                      )),
                                ),
                                const Text(
                                  "  Other",
                                  style: TextStyle(
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ],
                            )),
                      ],
                    ),
                    if (!isToEdit)
                      const SizedBox(
                        height: 10,
                      ),
                    if (!isToEdit && !isFromCartAddNew)
                      Row(
                        children: [
                          Checkbox(
                              checkColor: Colors.white,
                              activeColor: kYellowColor,
                              splashRadius: 12,
                              side: const BorderSide(
                                  // style: BorderStyle.none,
                                  width: 2,
                                  color: Colors.amber),
                              // fillColor:
                              //     MaterialStateProperty.all(Colors.amber),
                              value: isDefault,
                              onChanged: (value) {
                                mystate(() {
                                  isDefault = !isDefault;
                                });
                              }),
                          poppinsText(
                              txt: "Mark address as a default",
                              fontSize: 16,
                              weight: FontWeight.w500),
                        ],
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(200, 50),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        onPressed: () {
                          if (streetController.text.isEmpty ||
                              landMarkController.text.isEmpty) {
                            Utils.showToast('Please fill up the fields');
                          } else {
                            if (isToEdit && !isFromCartEdit) {
                              print("to edit");
                              addressProvider
                                  .editLocation(
                                      isDefault: isDefaultAddress ?? "1",
                                      addressId: addressId!,
                                      location:
                                          selectedPlace.formattedAddress ?? "",
                                      longitude: selectedPlace
                                          .geometry!.location.lng
                                          .toString(),
                                      latitude: selectedPlace
                                          .geometry!.location.lat
                                          .toString(),
                                      street: streetController.text,
                                      landmark: landMarkController.text,
                                      addressType: addressProvider.addressType)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Location Saved',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddressListScreen(),
                                  ),
                                );
                              });
                            } else if (isFromCartEdit) {
                              addressProvider
                                  .editLocation(
                                      isDefault: isDefaultAddress ?? "1",
                                      addressId: addressId!,
                                      location:
                                          selectedPlace.formattedAddress ?? "",
                                      longitude: selectedPlace
                                          .geometry!.location.lng
                                          .toString(),
                                      latitude: selectedPlace
                                          .geometry!.location.lat
                                          .toString(),
                                      street: streetController.text,
                                      landmark: landMarkController.text,
                                      addressType: addressProvider.addressType)
                                  .then((value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartScreen(),
                                  ),
                                );
                              });
                            } else if (isFromCartAddNew) {
                              addressProvider
                                  .addNewAddress(
                                isDefaultAddress: isDefault,
                                location: selectedPlace.formattedAddress ?? "",
                                longitude: selectedPlace.geometry!.location.lng
                                    .toString(),
                                latitude: selectedPlace.geometry!.location.lat
                                    .toString(),
                                street: streetController.text,
                                landmark: landMarkController.text,
                                addressType: addressProvider.addressType,
                              )
                                  .then((value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartScreen(),
                                  ),
                                );
                              });
                            } else {
                              addressProvider
                                  .addNewAddress(
                                isDefaultAddress: isDefault,
                                location: selectedPlace.formattedAddress ?? "",
                                longitude: selectedPlace.geometry!.location.lng
                                    .toString(),
                                latitude: selectedPlace.geometry!.location.lat
                                    .toString(),
                                street: streetController.text,
                                landmark: landMarkController.text,
                                addressType: addressProvider.addressType,
                              )
                                  .then((value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddressListScreen(),
                                  ),
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        elevation: 6,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 8,
                                                    offset: Offset(0, 1),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: GestureDetector(
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.cancel,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 45,
                                                    top: 7,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Image.asset(
                                                        Assets.icons
                                                            .savedSuccessfully,
                                                        fit: BoxFit.contain,
                                                        width: SizeConfig
                                                                .screenWidth! *
                                                            0.4,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'Address saved successfully',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              GoogleFonts.salsa(
                                                            textStyle:
                                                                TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 27,
                                                              // fontWeight: weight,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                      );
                                    });
                              });
                            }
                          }
                        },
                        child: poppinsText(
                            txt: "Save Address",
                            fontSize: 16,
                            color: Colors.white,
                            weight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      });
}

Future<void> updateAndAddNewLocationBottomSheet({
  required BuildContext context,
  required PickResult selectedPlace,
}) {
  bool isDefault = true;
  final streetController = TextEditingController();
  final landMarkController = TextEditingController();

  final addressProvider = Provider.of<UserLocations>(context, listen: false);

  return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter mystate) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xdba7a5a5)),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            RotatingIcon(
                              icon: Icon(
                                Icons.my_location,
                                color: Colors.red,
                              ),
                            ),
                            VerticalDivider(
                              color: Color(0xffA7A5A5),
                            ),
                            Expanded(
                                child: poppinsText(
                              txt: selectedPlace.formattedAddress ?? "",
                              maxLines: 3,
                              color: Color(0xFF8F8F8F),
                              weight: FontWeight.w400,
                              fontSize: 12,
                            )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      cursorColor: kYellowColor,
                      decoration: InputDecoration(
                        hintText: "Type Door/ Flat No, Street, etc..",
                        hintStyle: const TextStyle(
                            fontFamily: AppConstant.fontRegular),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 3,
                            style: BorderStyle.none,
                            color: Color(0xdba7a5a5),
                          ),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xdba7a5a5)),
                        ),
                      ),
                      controller: streetController,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      cursorColor: kYellowColor,
                      decoration: InputDecoration(
                        hintText: "Landmark",
                        hintStyle: const TextStyle(
                            fontFamily: AppConstant.fontRegular),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              width: 3,
                              style: BorderStyle.none,
                              color: Color(0xdba7a5a5)),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xdba7a5a5)),
                        ),
                      ),
                      controller: landMarkController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkResponse(
                            onTap: () {
                              addressProvider.updateAddressType("Home");

                              mystate(() {});
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 19,
                                  width: 19,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: addressProvider.addressType ==
                                                  "Home"
                                              ? kYellowColor
                                              : Color(0xffA8A7A7),
                                          width: 1)),
                                  child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: addressProvider.addressType ==
                                                "Home"
                                            ? kYellowColor
                                            : Colors.white,
                                      )),
                                ),
                                const Text(
                                  "  Home",
                                  style: TextStyle(
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 36,
                        ),
                        InkResponse(
                            onTap: () {
                              addressProvider.updateAddressType("Office");

                              mystate(() {});
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 19,
                                  width: 19,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: addressProvider.addressType ==
                                                  "Office"
                                              ? kYellowColor
                                              : Color(0xffA8A7A7),
                                          width: 1)),
                                  child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: addressProvider.addressType ==
                                                "Office"
                                            ? kYellowColor
                                            : Colors.white,
                                      )),
                                ),
                                const Text(
                                  "  Office",
                                  style: TextStyle(
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 36,
                        ),
                        InkResponse(
                            onTap: () {
                              addressProvider.updateAddressType("Other");

                              mystate(() {});
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 19,
                                  width: 19,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: addressProvider.addressType ==
                                                  "Other"
                                              ? kYellowColor
                                              : Color(0xffA8A7A7),
                                          width: 1)),
                                  child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: addressProvider.addressType ==
                                                "Other"
                                            ? kYellowColor
                                            : Colors.white,
                                      )),
                                ),
                                const Text(
                                  "  Other",
                                  style: TextStyle(
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: Colors.white,
                            activeColor: kYellowColor,
                            splashRadius: 12,
                            side: const BorderSide(
                                // style: BorderStyle.none,
                                width: 2,
                                color: Colors.amber),
                            // fillColor:
                            //     MaterialStateProperty.all(Colors.amber),
                            value: isDefault,
                            onChanged: (value) {
                              mystate(() {
                                isDefault = !isDefault;
                              });
                            }),
                        poppinsText(
                            txt: "Mark address as a default",
                            fontSize: 16,
                            weight: FontWeight.w500),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(200, 50),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        onPressed: () {
                          if (streetController.text.isEmpty ||
                              landMarkController.text.isEmpty) {
                            Utils.showToast('Please fill up the fields');
                          } else {
                            addressProvider
                                .addNewAddress(
                              isDefaultAddress: isDefault,
                              location: selectedPlace.formattedAddress ?? "",
                              longitude: selectedPlace.geometry!.location.lng
                                  .toString(),
                              latitude: selectedPlace.geometry!.location.lat
                                  .toString(),
                              street: streetController.text,
                              landmark: landMarkController.text,
                              addressType: addressProvider.addressType,
                            )
                                .then((value) {
                              addressProvider.updateMostRecentSavedAddress(
                                  UserLocationTypes(
                                id: '',
                                isDefault: isDefault ? '1' : '0',
                                address: selectedPlace.formattedAddress ?? "",
                                longitude: selectedPlace.geometry!.location.lng
                                    .toString(),
                                latitude: selectedPlace.geometry!.location.lat
                                    .toString(),
                                street: streetController.text,
                                landmark: landMarkController.text,
                                addressType: addressProvider.addressType,
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Location Saved',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );

                              Navigator.pop(context);
                            });
                          }
                        },
                        child: poppinsText(
                            txt: "Save Address",
                            fontSize: 16,
                            color: Colors.white,
                            weight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      });
}
