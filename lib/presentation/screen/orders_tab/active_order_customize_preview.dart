import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/main.dart';
import 'package:food_app/model/Profile/get_profile.dart';
import 'package:food_app/model/get_delivery_time.dart';
import 'package:food_app/model/orders/get_order_history_detail.dart';
import 'package:food_app/network/orders_repo/get_delivery_time_model.dart';
import 'package:food_app/network/profile_repo.dart';
import 'package:food_app/network/user/user_address_model.dart';
import 'package:food_app/presentation/screen/cart/change_address_screen.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/address/get_user_address_details.dart';
import '../../../model/user/user_address_list.dart';
import '../../../network/orders_repo/update_order_item_details_model.dart';
import 'order_history_preview.dart';

class ActiveOrderCustomizeScreen extends StatefulWidget {
  final OrderDetailsModel orderData;

  const ActiveOrderCustomizeScreen({
    super.key,
    required this.orderData,
  });

  @override
  State<ActiveOrderCustomizeScreen> createState() =>
      _ActiveOrderCustomizeScreenState();
}

class _ActiveOrderCustomizeScreenState
    extends State<ActiveOrderCustomizeScreen> {
  OrderDetailsModel? orderData;
  List<UserAddressDetails>? addressData = [];
  List? menuData = [];

  var isSelected = -1;
  var isSelectedDate = -1;
  var isSelectedAddress = -1;

  late String deliveryFromTime;
  late String deliveryToTime;
  String address = '';
  var time = "";
  Future? future;

  var myDescription = TextEditingController();
  bool isWalletActive = false;
  bool? isOrderNow = false;
  double totalToAmount = 0;
  String walletBalance = '';
  bool isWalletAmountAvailable = true;
  late String deliveryAddress;
  UserLocationTypes? location;
  late UserAddressListData addressList;
  @override
  void initState() {
    super.initState();
    loadAddresses();
    getProfileDetails();
    deliveryToTime = widget.orderData.items!.first.deliveryTotime ?? "";//widget.orderData.deliveryToTime ?? ""
    deliveryFromTime = widget.orderData.items!.first.deliveryFromtime ?? "";//widget.orderData.deliveryFromTime ?? ""
    orderData = widget.orderData;
    deliveryAddress =  "";//orderData?.deliveryAddress ?? ""

    myDescription.text =  "";//orderData!.description ?? ""
  }

  void loadAddresses() async {
    final addressProvider =
        Provider.of<UserAddressModel>(context, listen: false);
    final data = await addressProvider.getUserAddress();
    addressList = data.data;
  }

  @override
  Widget build(BuildContext context) {
    final updateModel =
        Provider.of<UpdateActiveOrdersCustomizationMenuItemsModel>(context,
            listen: false);
    final timeModel = Provider.of<GetDeliveryTimeModel>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          leadingWidth: 40,
          backgroundColor: Colors.white, //AppConstant.appColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SvgPicture.asset(
                'assets/images/Xback.svg',
                height: 20,
                width: 20,
              ),
            ),
          ),
          title: const Text(
            "Customize", //Order Customization
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                /*fontFamily: AppConstant.fontRegular,*/ color: Colors.black),
          ),
        ),
        backgroundColor: AppConstant.appColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              /* borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),*/
              color: Colors.white),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${dateTimeFormat(orderData!.items.toString(), "EEEE")} ",//orderData!.date.toString()
                      //"${dateTimeFormat(orderData!.date.toString(), "EEEE")} ",//orderData!.date.toString()
                      style: const TextStyle(
                          fontFamily: AppConstant.fontBold,
                          fontSize: 18,
                          color: AppConstant.appColor),
                    ),
                   /* Row(
                      children: [
                        const Text(
                          "Customize  ",
                          style: TextStyle(
                            color: AppConstant.appColor,
                            fontFamily: AppConstant.fontRegular,
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/images/customize.svg",
                          color: AppConstant.appColor,
                          height: 15,
                          width: 15,
                        )
                      ],
                    )*/
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
              // Text(
              //   "${orderData!.dishItem == null ? "" : orderData!.dishItem} ",
              //   style: const TextStyle(
              //       fontSize: 14, fontFamily: AppConstant.fontRegular),
              // ),
                const SizedBox(
                  height: 12,
                ),
                totalToAmount == 0
                    ? Container()
                    : Column(
                        children: [
                          Text(
                            " Extra Amount to Pay ${AppConstant.rupee} ${isWalletActive == false ? totalToAmount : "0"}",
                            style: const TextStyle(
                                fontFamily: AppConstant.fontRegular),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child: Row(
                              children: [
                                const Text(
                                  "Wallet ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 16),
                                ),
                                Transform.scale(
                                  scale: 1.5,
                                  child: Switch(
                                    value: isWalletActive,
                                    onChanged: (value) {
                                      print(value);
                                      print(isWalletActive);
                                      updateWalletStatus(value);
                                    },
                                    // inactiveThumbColor: Colors.red,
                                    // inactiveTrackColor: Colors.red.shade300,
                                    activeColor: AppConstant.appColor,
                                    activeTrackColor:
                                        const Color.fromARGB(255, 253, 202, 51),
                                  ),
                                ),
                                Text(
                                  " (${AppConstant.rupee}$walletBalance)",
                                  style: const TextStyle(
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                const Spacer(),
                                Text(
                                  "To Pay ₹ ${isWalletActive == false ? totalToAmount : "0"}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Arriving At",
                          style: TextStyle(
                              fontFamily: AppConstant.fontBold,
                              fontSize: 18,
                              color: AppConstant.appColor),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          deliveryToTime != ''
                              ? '${deliveryFromTime} - ${deliveryToTime}'
                              : "${DateFormat.jm().format(
                                  DateFormat("hh:mm").parse(
                                    orderData!.items!.first.deliveryFromtime.toString(),
                                   // orderData!.deliveryFromTime.toString(),
                                  ),
                                )} - ${DateFormat.jm().format(
                                  DateFormat("hh:mm")
                                      .parse(orderData!.items!.first.deliveryTotime!),
                                      //.parse(orderData!.deliveryToTime!),
                                )} ",
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: AppConstant.fontRegular),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppConstant.appColor,
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 8.0, right: 8),
                                                child: Image(
                                                  image: AssetImage(
                                                      "assets/images/cross_outline.png"),
                                                  height: 24,
                                                  width: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(
                                                'Change Arriving Time',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: AppConstant.appColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          FutureBuilder<GetDeliveryTime>(
                                              future: timeModel.getDeliveryTime(widget.orderData.kitchenId!,"", /*widget.orderData.referenceId!,*/ /* widget.orderData.mealFor!*/
                                              ),
                                              builder: (context, snapshot) {
                                               // print(widget.orderData.referenceId);
                                                return snapshot.connectionState == ConnectionState.done && snapshot.data != null
                                                    ? Container(
                                                  margin: const EdgeInsets.only(bottom: 8),
                                                  height: 112,
                                                  decoration: const BoxDecoration(
                                                      //color: Colors.red,
                                                      borderRadius:
                                                      BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),

                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                            children: [
                                                              GridView.builder(
                                                                physics: NeverScrollableScrollPhysics(),//const BouncingScrollPhysics(),
                                                                shrinkWrap: true,
                                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                  mainAxisSpacing: 4,
                                                                  crossAxisSpacing: 0,
                                                                  crossAxisCount: 3,
                                                                  childAspectRatio: 20 / 6,
                                                                ),
                                                                itemCount: snapshot.data!.data!.length,
                                                                itemBuilder: (context, index) {
                                                                  var timeSplit = snapshot.data!.data![index].split("-");
                                                                  return Padding(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        setState(
                                                                            () {
                                                                          isSelectedDate = index;
                                                                          deliveryFromTime = '${dateTimeFormat("1995-01-01 ${timeSplit[0]}", "hh:mm a")}';
                                                                          deliveryToTime =
                                                                              '${dateTimeFormat("1995-01-01 ${timeSplit[1]}", "hh:mm a")}';
                                                                          time = snapshot
                                                                              .data
                                                                              .toString();
                                                                          time.split(
                                                                              " ");
                                                                        });
                                                                        Navigator.pop(
                                                                            context,
                                                                            'OK');
                                                                      },
                                                                      child: isSelectedDate ==
                                                                              index
                                                                          ? Container(
                                                                              height: 20,
                                                                              decoration: BoxDecoration(
                                                                                color: AppConstant.appColor,
                                                                                borderRadius: BorderRadius.circular(5),
                                                                              ),
                                                                              child:
                                                                                  Center(
                                                                                child:
                                                                                    FittedBox(
                                                                                      child: Text(
                                                                                  " ${dateTimeFormat("1995-01-01 ${timeSplit[0]}", "hh:mm a")} - ${dateTimeFormat("1995-01-01 ${timeSplit[1]}", "hh:mm a")} ",//.replaceAll("AM", "").replaceAll("PM", "")
                                                                                  style: const TextStyle(color: Colors.white, fontFamily: AppConstant.fontRegular),
                                                                                ),
                                                                                    ),
                                                                              ),
                                                                            )
                                                                          : Container(

                                                                              decoration:
                                                                                  BoxDecoration(
                                                                                border:
                                                                                    Border.all(
                                                                                  color: Colors.grey,
                                                                                  width: 1,
                                                                                ),
                                                                                borderRadius:
                                                                                    BorderRadius.circular(5),
                                                                              ),
                                                                              child:
                                                                                  Center(
                                                                                child:
                                                                                    FittedBox(
                                                                                      child: Text(
                                                                                  " ${DateFormat.jm().format(DateFormat("hh:mm").parse(timeSplit[0]))} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(timeSplit[1]))} ",
                                                                                  //data.toString(),
                                                                                  style: const TextStyle(color: Color.fromRGBO(47, 52, 67, 0.8), fontFamily: AppConstant.fontRegular),
                                                                                ),
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              /* SizedBox(
                                                          height: 200,
                                                                    child: ListView.builder(
                                                                            shrinkWrap: true,
                                                                            itemCount: snapshot.data!.data!.length,
                                                                            itemBuilder: (context, index) {
                                                                              var timeSplit = snapshot.data!.data![index].split("-");
                                                                              return Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      isSelectedDate = index;
                                                                                      deliveryFromTime = '${dateTimeFormat("1995-01-01 ${timeSplit[0]}", "hh:mm a")}';
                                                                                      deliveryToTime = '${dateTimeFormat("1995-01-01 ${timeSplit[1]}", "hh:mm a")}';
                                                                                      time = snapshot.data.toString();
                                                                                      time.split(" ");
                                                                                    });
                                                                                    Navigator.pop(context,
                                                                                        'OK');
                                                                                  },
                                                                                  child: isSelectedDate == index
                                                                                      ? Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: AppConstant.appColor,
                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(10.0),
                                                                                            child: Text(" ${dateTimeFormat("1995-01-01 ${timeSplit[0]}", "hh:mm a").replaceAll("AM", "").replaceAll("PM", "")} - ${dateTimeFormat("1995-01-01 ${timeSplit[1]}", "hh:mm a").replaceAll("AM", "").replaceAll("PM", "")} ",
                                                                                              //" ${dateTimeFormat("1995-01-01 ${timeSplit[0]}", "hh:mm a")} - ${dateTimeFormat("1995-01-01 ${timeSplit[1]}", "hh:mm a")} ",
                                                                                              style: const TextStyle(color: Colors.white, fontFamily: AppConstant.fontRegular),
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      : Container(
                                                                                          decoration: BoxDecoration(
                                                                                            border: Border.all(
                                                                                              color: AppConstant.appColor,
                                                                                              width: 2,
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(10.0),
                                                                                            child: Text(
                                                                                              " ${DateFormat.jm().format(DateFormat("hh:mm").parse(timeSplit[0])).replaceAll("AM", "").replaceAll("PM", "")} - ${DateFormat.jm().format(DateFormat("hh:mm").parse(timeSplit[1])).replaceAll("AM", "").replaceAll("PM", "")} ",                                                                                          //data.toString(),
                                                                                              style: const TextStyle(color: Colors.black, fontFamily: AppConstant.fontRegular),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                ),
                                                                              );
                                                                            }),
                                                                  ),*/
                                                            ],
                                                          ),
                                                      ),
                                                    )
                                                    : const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ));
                            });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        fixedSize: MaterialStateProperty.all(
                          const Size(70, 30),
                        ),
                      ),
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppConstant.fontRegular,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Delivery Address",
                          style: TextStyle(
                              fontFamily: AppConstant.fontBold,
                              fontSize: 18,
                              color: AppConstant.appColor),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 210,
                          //color: Colors.red,
                          child: Text(
                            deliveryAddress,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: AppConstant.fontRegular),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeAddress(
                                  selectedAddressID: "",
                                  addressList: addressList)),
                        );
                        // try {
                        //   final UserLocationTypes newLocation =
                        //   await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => UpdateOrderAddressScreen(),
                        //     ),
                        //   );
//
                        //   setState(() {
                        //     location = newLocation;
                        //     deliveryAddress =
                        //     '${location!.street}, ${location!.landmark}, ${location!.address}';
                        //   });
                        // } catch (e) {
                        //   print(e);
                        // }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        fixedSize: MaterialStateProperty.all(
                          const Size(100, 40),
                        ),
                      ),
                      child: const Text(
                        "Change",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppConstant.fontRegular,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Add Instructions",
                  style: TextStyle(
                      fontFamily: AppConstant.fontBold,
                      fontSize: 20,
                      color: AppConstant.appColor),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  child: TextField(
                    maxLines: 5,
                    controller: myDescription,
                    cursorHeight: 20,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                          fontFamily: AppConstant.fontRegular, fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    updateModel.updateOrderItems(
                      orderDetailsModel: OrderDetailsModel(
                        /*orderId: widget.orderData.orderId,
                        orderItemsId: widget.orderData.orderItemsId,
                        deliveryAddress: deliveryAddress,
                        deliveryFromTime: deliveryFromTime,
                        deliveryToTime: deliveryToTime,
                        description: myDescription.text.trim(),*/
                      ),
                      userLocation: location != null
                          ? UserLocationTypes(
                              isDefault: location!.isDefault,
                              id: location!.id,
                              longitude: location!.longitude,
                              latitude: location!.latitude,
                              street: location!.street,
                              landmark: location!.landmark,
                              addressType: location!.addressType,
                              address: location!.address)
                          : null,
                    )
                        .then((response) {
                      if (response.statusCode == 200) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderHistoryPreview(
                                    orderId: widget.orderData.orderId!,
                                    orderItemId: widget.orderData.items?.first.orderItemId,// widget.orderData.orderItemsId!
                                  )),
                        );
                        menuData == null
                            ? null
                            : updateModel.transactionSuccess(response.body);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Changes Saved successfully",
                              style: TextStyle(
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          ),
                        );
                      } else {
                        const Text("Can update before 12 hours only");
                      }
                    });
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      const Size(450, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: Text(
                    totalToAmount > 0 ? "Save & Pay" : "Save",
                    style: const TextStyle(
                        fontFamily: AppConstant.fontRegular, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                )
              ],
            ),
          ),
        ));
  }

  Future<GetProfile?> getProfileDetails() async {
    final profileModel = Provider.of<ProfileModel>(context, listen: false);

    GetProfile? bean = await profileModel.getProfile();

    if (bean!.status == true) {
      setState(() {
        walletBalance = bean.data[0].myWallet;
      });
      return bean;
    } else {
      Utils.showToast(
        bean.message.toString(),
      );
    }

    return null;
  }

  void updateWalletStatus(value) {
    setState(() {
      isWalletActive = value;
      isWalletAmountAvailable = value;
      if (value == true) {
        totalToAmount;
      } else {
        totalToAmount;
        //double.parse(totalToAmount.toString())-double.parse(walletBalance) ;
        if (totalToAmount < 0) {
          //totalToAmount = 0;
        }
      }
    });
  }
}
