import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/presentation/screen/location_collections/address_list_screen.dart';
import 'package:provider/provider.dart';

import '../../../../model/user/user_address_list.dart';
import '../../../../network/user/user_address_model.dart';
import '../../../../utils/constants/ui_constants.dart';

Future<void> showAddressListDialog(BuildContext context, UserAddressListData addressList,) async {
  String? radioGroupValue;
  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Builder(builder: (context) {
              return (addressList.home.isEmpty && addressList.office.isEmpty && addressList.other.isEmpty)
                  ? Text(
                      "No Address Found",
                      style: AppTextStyles.normalText.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var address in addressList.home)
                          RadioListTile<String>(
                            activeColor: kYellowColor,
                            contentPadding: EdgeInsets.zero,
                            dense: false,
                            visualDensity: VisualDensity.compact,
                            value: address.id,
                            groupValue: radioGroupValue,
                            onChanged: (val) {
                              radioGroupValue = val;

                              setState(() {});
                            },
                            title: Text(
                                "${address.street}, ${address.landmark}, ${address.address}"),
                            toggleable: true,
                            selected: radioGroupValue == address.id,
                          ),
                        for (var address in addressList.office)
                          RadioListTile<String>(
                            activeColor: kYellowColor,
                            contentPadding: EdgeInsets.zero,
                            dense: false,
                            visualDensity: VisualDensity.compact,
                            value: address.id,
                            groupValue: radioGroupValue,
                            onChanged: (val) {
                              radioGroupValue = val;

                              setState(() {});
                            },
                            title: Text(
                                "${address.street}, ${address.landmark}, ${address.address}"),
                            toggleable: true,
                            selected: radioGroupValue == address.id,
                          ),
                        for (var address in addressList.other)
                          RadioListTile<String>(
                            activeColor: kYellowColor,
                            contentPadding: EdgeInsets.zero,
                            value: address.id,
                            dense: false,
                            visualDensity: VisualDensity.compact,
                            groupValue: radioGroupValue,
                            onChanged: (val) {
                              radioGroupValue = val;

                              setState(() {});
                            },
                            title: Text(
                                "${address.street}, ${address.landmark}, ${address.address}"),
                            toggleable: true,
                            selected: radioGroupValue == address.id,
                          ),
                      ],
                    );
            }),
            title: Text(
              'Choose Address',
              style: AppTextStyles.normalText.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kYellowColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AddressListScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Add Address",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kYellowColor,
                    ),
                    onPressed: () {
                      final addressProvider =
                          Provider.of<UserAddressModel>(context, listen: false);
                      if (radioGroupValue == null) {
                        return;
                      }
                      addressProvider.makeAddressDefault(radioGroupValue!);
                      print(radioGroupValue);

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
      });
}
