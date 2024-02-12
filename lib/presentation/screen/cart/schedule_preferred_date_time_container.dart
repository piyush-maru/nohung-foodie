import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:provider/provider.dart';

import '../../../model/cart_screen_class/pre_order_dates.dart';
import '../../../model/cart_screen_class/pre_order_time.dart';
import '../../../network/cart_repo/pre_order_model.dart';
import '../../../network/pre_order/pre_order_provider.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/helper_class.dart';
import '../../../utils/size_config.dart';

class ScheduleDateTimeContainer extends StatefulWidget {
  final bool isFromDialog;
  final String kitchenID;
  const ScheduleDateTimeContainer({
    super.key,
    required this.kitchenID,
    this.isFromDialog = false,
  });

  @override
  State<ScheduleDateTimeContainer> createState() =>
      _ScheduleDateTimeContainerState();
}

class _ScheduleDateTimeContainerState extends State<ScheduleDateTimeContainer> {
  int _tileValueKey1 = 1; // Initial value key

  void _updateTileValueKey() {
    setState(() {
      _tileValueKey1++; // Update the value key
    });
  }

  int _tileValueKey2 = 1; // Initial value key

  void _updateTileValueKey2() {
    setState(() {
      _tileValueKey2++; // Update the value key
    });
  }

  Future<void> _openAlertDialog() async {
    await showDialog<void>(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.2),
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
          return Dialog(
            backgroundColor: Colors.transparent,
            insetAnimationDuration: const Duration(seconds: 1),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              // Set rounded corners
            ),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                padding: const EdgeInsets.only(left: 20,bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset("assets/images/cross_outline.png",
                          height: 23),
                        ),
                      ),
                    ),
                   // SvgPicture.asset('assets/images/leaf.svg'),
                    const Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.redAccent,
                      size: 40,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    poppinsText(
                        txt: 'Select a time for delivery',
                        maxLines: 2,
                        fontSize: 16)
                  ],
                )),
          );
        }
        );

  }

  @override
  Widget build(BuildContext context) {
    final preOrderProvider = Provider.of<PreorderProvider>(context);

    final String currentDate = preOrderProvider.selectedDate;
    final String currentTime = preOrderProvider.selectedTime;
    final bool isKitchenCloseToday = preOrderProvider.isKitchenCloseToday;
    final preOrderModel = Provider.of<PreOrderModel>(context, listen: false);
    String? selectTime;
    handleDateAndTime(BuildContext context, String newTime) {
      final preOrderProvider =
          Provider.of<PreorderProvider>(context, listen: false);

      preOrderProvider.updateTimeFinal(newTime);
      preOrderProvider.updatePreOrderDateAndTime(
        deliveryTime: newTime,
        kitchenId: widget.kitchenID,
        context: context,
      );
    }

    handleTime(
      BuildContext context,
    ) {
      preOrderProvider.updateTimeFinal('Select Time');

      // final preOrderProvider =
      //     Provider.of<PreorderProvider>(context, listen: false);
      //
      // preOrderProvider.updateTime("Select Time");
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: widget.isFromDialog
            ? Border.all(
                width: 2,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: const Color(0xFFFFDA78),
              )
            : null,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Schedule Your Preferred Date & Time:",
                  style: AppTextStyles.boldText.copyWith(fontSize: 14),
                ),
                if (widget.isFromDialog)
                  GestureDetector(
                    onTap: () {
                      print('nikhil answer is ${preOrderProvider.finalTime}');
                      if (selectTime!.isEmpty || selectTime == "Select Time") {
                        _openAlertDialog();
                      } else {
                        // preOrderProvider.updateTime('');
                        // preOrderProvider.updateDate(
                        //     snapshot.data!.data[index].formattedDate);
                        Navigator.pop(context);
                      }
                    },
                    child: const Icon(Icons.close),
                  )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            if (isKitchenCloseToday)
              Text(
                "Kitchen Is Closed Today",
                style: AppTextStyles.boldText
                    .copyWith(color: const Color(0xFFEA0000)),
              ),
            if (isKitchenCloseToday)
              const SizedBox(
                height: 12,
              ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 10,
                    offset: Offset(4, 3),
                    spreadRadius: 2,
                  )
                ],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: const Color(0xFFFFDA78),
                ),
              ),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: FutureBuilder<GetPreOrderDates>(
                    future: preOrderModel.preOrderDates(widget.kitchenID),
                    builder: (context, datesSnapshot) {
                      if (datesSnapshot.hasData &&
                          datesSnapshot.connectionState ==
                              ConnectionState.done) {
                        return FutureBuilder<GetPreOrderTime>(
                            future: preOrderModel.preOrderTimes(
                                widget.kitchenID,
                                isKitchenCloseToday
                                    ? Helper.formatDateFromDateTime(
                                        DateTime.now().add(Duration(days: 1)))
                                    : preOrderProvider.selectedUnformattedDate),
                            builder: (context, timeSnapshot) {
                              if (timeSnapshot.hasData &&
                                  timeSnapshot.connectionState ==
                                      ConnectionState.done) {
                                print("nikhil pre pre currentime $currentTime");
                                if (currentTime.isEmpty) {
                                  print(
                                      "nikhil pre pre eliver ${timeSnapshot.data?.data.first.text}");

                                  if (timeSnapshot.data?.data.first.text ==
                                      "Deliver Now : Within 60mins") {
                                    handleDateAndTime(context,
                                        timeSnapshot.data!.data.first.value);
                                  } else {
                                    handleTime(context);
                                  }
                                }
                                selectTime = currentTime.isEmpty
                                    ? timeSnapshot.data?.data.first.text ==
                                            "Deliver Now : Within 60mins"
                                        ? isKitchenCloseToday
                                            ? "Select Time"
                                            : timeSnapshot.data?.data.first.text
                                        : 'Select Time'
                                    : currentTime;
                                return ExpansionTile(
                                  tilePadding: const EdgeInsets.all(0),

                                  backgroundColor: Colors.white,
                                  iconColor: Colors.black,
                                  initiallyExpanded: true,
                                  // iconColor: Color(0xFFFFD978),
                                  title: Container(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.watch_later,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              "Delivery Date: ",
                                                          style: AppTextStyles
                                                              .boldText,
                                                        ),
                                                        TextSpan(
                                                          text: currentDate
                                                                  .isEmpty
                                                              ? datesSnapshot
                                                                  .data
                                                                  ?.data
                                                                  .first
                                                                  .formattedDate
                                                              : currentDate,
                                                          style: AppTextStyles
                                                              .normalText,
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              "Delivery Timing: ",
                                                          style: AppTextStyles
                                                              .boldText,
                                                        ),
                                                        TextSpan(
                                                          text: selectTime,
                                                          style: AppTextStyles
                                                              .normalText,
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  children: [
                                    const Divider(
                                      color: Colors.black54,
                                      thickness: 1,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFD978),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                            dividerColor: Colors.transparent),
                                        child: ExpansionTile(
                                          key: ValueKey(
                                              _tileValueKey2), // Use the dynamic value key

                                          tilePadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8),
                                          iconColor: Colors.black,
                                          title: Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_today,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                currentDate.isEmpty
                                                    ? datesSnapshot.data!.data
                                                        .first.formattedDate
                                                    : currentDate,
                                                style: AppTextStyles.normalText,
                                              ),
                                            ],
                                          ),
                                          children: [
                                            SizedBox(
                                              height: SizeConfig.screenHeight! *
                                                  0.2,
                                              child: RawScrollbar(
                                                thumbColor:
                                                    const Color(0xFFDEDDDD),
                                                child: ListView.builder(
                                                  // physics:
                                                  //     NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        _updateTileValueKey2(); // Update the value key on child click

                                                        preOrderProvider.updateDate(
                                                            datesSnapshot
                                                                .data!
                                                                .data[index]
                                                                .formattedDate);
                                                        preOrderProvider
                                                            .updateUnformattedDate(
                                                                datesSnapshot
                                                                    .data!
                                                                    .data[index]
                                                                    .date);

                                                        preOrderProvider
                                                            .updateTime('');
                                                        preOrderProvider
                                                            .updateTimeFinal(
                                                                '');
                                                      },
                                                      child: DecoratedBox(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 3,
                                                                  vertical: 2),
                                                          width:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                              color: currentDate ==
                                                                      datesSnapshot
                                                                          .data!
                                                                          .data[
                                                                              index]
                                                                          .formattedDate
                                                                  ? const Color(
                                                                      0xFFFFF5C2)
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      30),
                                                          child: Text(
                                                            datesSnapshot
                                                                .data!
                                                                .data[index]
                                                                .formattedDate,
                                                            style: AppTextStyles
                                                                .normalText,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  itemCount: datesSnapshot
                                                      .data?.data.length,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFD978),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent),
                                            child: ExpansionTile(
                                              key: ValueKey(
                                                  _tileValueKey1), // Use the dynamic value key
                                              tilePadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              iconColor: Colors.black,
                                              title: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.watch_later,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    currentTime.isNotEmpty
                                                        ? currentTime
                                                        : timeSnapshot
                                                                    .data
                                                                    ?.data
                                                                    .first
                                                                    .isWithin60Minute !=
                                                                1
                                                            ? "Select Time"
                                                            : isKitchenCloseToday
                                                                ? "Select Time"
                                                                : timeSnapshot
                                                                    .data!
                                                                    .data
                                                                    .first
                                                                    .text,
                                                    style: AppTextStyles
                                                        .normalText,
                                                  ),
                                                ],
                                              ),
                                              children: [
                                                SizedBox(
                                                  height:
                                                      SizeConfig.screenHeight! *
                                                          0.25,
                                                  child: (timeSnapshot
                                                              .hasData &&
                                                          timeSnapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .done)
                                                      ? RawScrollbar(
                                                          thumbColor:
                                                              const Color(
                                                                  0xFFDEDDDD),
                                                          child:
                                                              ListView.builder(
                                                            // physics: BouncingScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              if (index ==
                                                                  timeSnapshot
                                                                      .data!
                                                                      .data
                                                                      .length) {
                                                                return const DecoratedBox(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 44,
                                                                  ),
                                                                );
                                                              } else {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    _updateTileValueKey(); // Update the value key on child click

                                                                    preOrderProvider.updateTime(timeSnapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .text);
                                                                    preOrderProvider.updateTimeFinal(timeSnapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .text);
                                                                    print(
                                                                        " ${timeSnapshot.data!.data[index].text}");
                                                                    preOrderProvider
                                                                        .updatePreOrderDateAndTime(
                                                                      deliveryTime: timeSnapshot
                                                                          .data!
                                                                          .data[
                                                                              index]
                                                                          .value,
                                                                      kitchenId:
                                                                          widget
                                                                              .kitchenID,
                                                                      context:
                                                                          context,
                                                                    );
                                                                  },
                                                                  child:
                                                                      DecoratedBox(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              3,
                                                                          vertical:
                                                                              2),
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          color: currentTime == timeSnapshot.data!.data[index].text
                                                                              ? const Color(0xFFFFF5C2)
                                                                              : Colors.white,
                                                                          borderRadius: BorderRadius.circular(6)),
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              8,
                                                                          horizontal:
                                                                              30),
                                                                      child:
                                                                          Text(
                                                                        timeSnapshot
                                                                            .data!
                                                                            .data[index]
                                                                            .text,
                                                                        style: AppTextStyles
                                                                            .normalText,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            itemCount:
                                                                timeSnapshot
                                                                        .data!
                                                                        .data
                                                                        .length +
                                                                    1,
                                                          ),
                                                        )
                                                      : const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: AppConstant
                                                                .appColor,
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (widget.isFromDialog)
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                print(
                                                    'nikhil answer is ${preOrderProvider.finalTime}');

                                                final time = currentTime
                                                        .isNotEmpty
                                                    ? currentTime
                                                    : timeSnapshot
                                                                .data
                                                                ?.data
                                                                .first
                                                                .isWithin60Minute !=
                                                            1
                                                        ? "Select Time"
                                                        : isKitchenCloseToday
                                                            ? "Select Time"
                                                            : timeSnapshot
                                                                .data!
                                                                .data
                                                                .first
                                                                .text;
                                                if (time == "Select Time") {
                                                  _openAlertDialog();
                                                } else if (time ==
                                                    "Deliver Now : Within 60mins") {
                                                  preOrderProvider
                                                      .updatePreOrderDateAndTime(
                                                    deliveryTime: timeSnapshot
                                                        .data!.data.first.value,
                                                    kitchenId: widget.kitchenID,
                                                    context: context,
                                                  );
                                                  Navigator.pop(context);
                                                } else {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7,
                                                        vertical: 6),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFFD978),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Text(
                                                  "Continue",
                                                  style: AppTextStyles.boldText,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    )
                                  ],
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppConstant.appColor,
                                ),
                              );
                            });
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppConstant.appColor,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
