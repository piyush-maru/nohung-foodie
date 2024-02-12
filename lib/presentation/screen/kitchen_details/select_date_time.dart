import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
// import 'package:material_scrollbar/material_scrollbar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../model/package_details_model/package_details_model.dart';
import '../../../network/cart_repo/cart_screen_model.dart';
import '../../../network/kitchen_details/kitchen_details_model.dart';
import '../../../network/selectDateTime/GetOfflineDatesModel.dart';
import '../../../network/selectDateTime/select_date_time_controller.dart';
import '../../../providers/delivery_time_and_dates_provider.dart';
import '../../../utils/Utils.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../../utils/helper_class.dart';
import '../../../utils/pref_manager.dart';
import '../authentication_screens/login/login_with_mobile_screen.dart';
import 'customized_subscription_package_details_screen.dart';

class SelectDateTime extends StatefulWidget {
  final String kitchenId;
  final MealPlan mealPlan;
  final MealForEnum mealFor;
  final PackageDetailsData packageDetailsData;

  const SelectDateTime({
    super.key,
    required this.kitchenId,
    required this.mealPlan,
    required this.mealFor,
    required this.packageDetailsData,
  });

  @override
  State<SelectDateTime> createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime>
    with TickerProviderStateMixin {
  String _selectedTime = '';
  String _selectedFromTime = '';
  final log = Logger();
  DateTime initialSelectedDate = DateTime.now();
  String _mealPlan = "weekly";
  String _startDate = "";
  String _endDate = "";
  bool isLoading = true;
  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();
  bool _isSatSelected = true;
  bool _isSunSelected = true;
  int _valueKey = 1; //
  int totalDays = 0;
  bool isRed=false;
  DateRangePickerSelectionChangedArgs? argsTemp;
  late TabController _tabControllerMealType;
  final controller = DateRangePickerController();
  DateTime? initialDate = DateTime.now().subtract(const Duration(days: 1));
  int? _radioValue = 0;
  var isSelected = -1;
  Future? future;
  String endDateString = '';
  DateTime? first;
  List<DateTime> OfflineDatesList = [];

  setWeekends() async {
    final dateTimeProvider =
        Provider.of<DeliveryTimeDateProvider>(context, listen: false);
    dateTimeProvider.updateIsSatSelected(
        widget.packageDetailsData.includingSaturday == "1");
    dateTimeProvider
        .updateIsSunSelected(widget.packageDetailsData.includingSunday == "1");
  }

  @override
  void initState() {
    super.initState();
    _tabControllerMealType = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setWeekends();
      _loadOfflineDates();
    });
  }

  void _loadOfflineDates() async {
    final offlineProvider =
        Provider.of<GetOfflineDatesModel>(context, listen: false);
    final isKitchenCloseModel =
        await offlineProvider.getOfflineDates(widget.kitchenId);
    for (var offlineDate in isKitchenCloseModel.data) {
      OfflineDatesList.add(offlineDate.date);
    }
    setState(() {
      isLoading = false;
    });
  }

  void _updateTileValueKey() {
    _valueKey++; // Update the value key
  }

  void updateDateRangeNumberOfDays() {
    setState(() {
      if (!_isSunSelected) {
        if (endDateTime.weekday == DateTime.sunday) {
          endDateTime = endDateTime.subtract(const Duration(days: 1));
        }
      }
      if (!_isSatSelected) {
        if (endDateTime.weekday == DateTime.saturday) {
          endDateTime = endDateTime.subtract(const Duration(days: 1));
        }
      }
      _endDate = DateFormat('yyyy-MM-dd').format(endDateTime);
      _startDate = DateFormat('yyyy-MM-dd').format(startDateTime);
    });
  }

  bool dayPredicate(
      DeliveryTimeDateProvider dateTimeProvider, DateTime currentDate,
      {List<DateTime> excludeDates = const []}) {
    if (!dateTimeProvider.isSatSelected && !dateTimeProvider.isSunSelected) {
      if (currentDate.weekday == DateTime.saturday ||
          currentDate.weekday == DateTime.sunday) {
        return false;
      }
      return true;
    } else if (!dateTimeProvider.isSatSelected &&
        dateTimeProvider.isSunSelected) {
      if (currentDate.weekday == DateTime.saturday) {
        return false;
      }
      return true;
    } else if (dateTimeProvider.isSatSelected &&
        !dateTimeProvider.isSunSelected) {
      if (currentDate.weekday == DateTime.sunday) {
        return false;
      }
      return true;
    } else {
      return true;
    }
  }

  void updateSelectedDateRange() {
    DateTime today = DateTime.now();
    if (today.weekday == 6) {
      initialDate = today;
    } else if (today.weekday == 7) {
      initialDate = today;
    } else if (initialDate!.weekday == 6) {
      initialDate = initialDate!.add(const Duration(days: 1));
    } else if (initialDate!.weekday == 7) {
      initialDate = initialDate!.add(const Duration(days: 1));
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    argsTemp = args;
    var additionalDays = 0;

    List<DateTime> dateTimes = [];
    if ((args.value as PickerDateRange).startDate != null &&
        (args.value as PickerDateRange).endDate != null) {
      DateTime currentDate = (args.value as PickerDateRange).startDate!;

      while (currentDate.isBefore((args.value as PickerDateRange).endDate!) ||
          currentDate
              .isAtSameMomentAs((args.value as PickerDateRange).endDate!)) {
        dateTimes.add(currentDate);
        currentDate = currentDate.add(const Duration(days: 1));
      }
      log.f(dateTimes);
      for (DateTime date in dateTimes) {
        if (date.weekday == DateTime.saturday &&
            widget.packageDetailsData.includingSaturday == "0") {
          print('iinclude new sat ');
          additionalDays += 1;
        }
        if (date.weekday == DateTime.sunday &&
            widget.packageDetailsData.includingSunday == "0") {
          print('iinclude new sun ');

          additionalDays += 1;
        }
      }

      for (var e in OfflineDatesList) {
        if (dateTimes.contains(e)) {
          if (e.weekday != DateTime.saturday && e.weekday != DateTime.sunday) {
            additionalDays += 1;
          } else if (e.weekday == DateTime.saturday &&
              widget.packageDetailsData.includingSaturday == "1" &&
              _isSatSelected) {
            additionalDays += 1;
          } else if (e.weekday == DateTime.sunday &&
              widget.packageDetailsData.includingSunday == "1" &&
              _isSunSelected) {
            additionalDays += 1;
          }
        }
      }
    }
    updateSelectedDateRange();
    initialDate = (args.value as PickerDateRange).startDate;
    initialSelectedDate = initialDate!;

    if (!Helper.isOrderTimeValid(
        time: _selectedFromTime, date: initialDate!, context: context)) {
      _selectedFromTime = '';
      _selectedTime = '';
    }
    endDateTime = initialDate!.add(Duration(
        days: _radioValue == 0
            ? (Helper.getNumberOfDaysInAWeek(
                        includingSaturday:
                            widget.packageDetailsData.includingSaturday,
                        includingSunday:
                            widget.packageDetailsData.includingSunday) -
                    1) +
                additionalDays
            : 29 + additionalDays));
    startDateTime = (args.value as PickerDateRange).startDate!;
    updateDateRangeNumberOfDays();
    controller.selectedRange = (PickerDateRange(
        initialDate!,
        initialDate!.add(Duration(
            days: _radioValue == 0
                ? (Helper.getNumberOfDaysInAWeek(
                            includingSaturday:
                                widget.packageDetailsData.includingSaturday,
                            includingSunday:
                                widget.packageDetailsData.includingSunday) -
                        1) +
                    additionalDays
                : 29 + additionalDays))));
  }

  void _changeWeeklyMonthlyDateRange(int value) {
    _radioValue = value;

    controller.selectedRange = (PickerDateRange(
        initialDate, initialDate!.add(Duration(days: value == 0 ? 7 : 30))));
  }

  final DateRangePickerController _controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    final dateTimeProvider =
        Provider.of<DeliveryTimeDateProvider>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        dateTimeProvider.updateIsSatSelected(false);
        dateTimeProvider.updateIsSunSelected(false);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), //20
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkResponse(
                        onTap: () {
                          dateTimeProvider.updateIsSatSelected(false);
                          dateTimeProvider.updateIsSunSelected(false);
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          "assets/images/backb.svg",
                          height: 27,
                          width: 27,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (widget.mealPlan.mealtype == "0")
                        SvgPicture.asset(
                          'assets/images/leaf.svg',
                          width: 30,
                        ),
                      if (widget.mealPlan.mealtype == "1")
                        SvgPicture.asset(
                          'assets/images/chicken.svg',
                          width: 30,
                        ),
                      if (widget.mealPlan.mealtype == "2")
                        SvgPicture.asset(
                          'assets/images/both.svg',
                          width: 30,
                        ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.packageDetailsData.packageName,
                              style: AppTextStyles.semiBoldText,
                            ),
                            Image.asset("assets/images/xyellow.png",
                                height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.packageDetailsData.description != ""
                            ? Text(
                                widget.packageDetailsData
                                    .description /*"₹ ${widget.packageDetailsData.price}"*/,
                                style: AppTextStyles.normalText.copyWith(
                                  fontSize: 12,
                                ),
                              )
                            : SizedBox(),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "${widget.packageDetailsData.mealFor} | ${Helper.getVegNonVegText(widget.packageDetailsData.mealType)} | ${widget.packageDetailsData.cuisineType}",
                          style: AppTextStyles.normalText,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (widget.packageDetailsData.provideCustomization ==
                            "y")
                          Text(
                            "Customization available",
                            style: AppTextStyles.normalText.copyWith(
                              color: kYellowColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),

                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(4, 3),
                            blurRadius: 3.0,
                            color: Colors.black12),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    child: IgnorePointer(
                      ignoring: widget.packageDetailsData.monthly == "0",
                      child: TabBar(
                          onTap: (value) {
                            _changeWeeklyMonthlyDateRange(value);

                            if (value == 0) {
                              _mealPlan = "weekly";
                            }
                            if (value == 1) {
                              _mealPlan = "monthly";
                            }
                          },
                          controller: _tabControllerMealType,
                          physics: const BouncingScrollPhysics(),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kYellowColor,
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor:
                              widget.packageDetailsData.monthly == "0"
                                  ? Colors.grey
                                  : Colors.black,
                          labelStyle: AppTextStyles.normalText.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          isScrollable: true,
                          tabs: const [
                            Tab(
                              text: "Weekly",
                            ),
                            Tab(
                              text: "Monthly",
                            ),
                          ]),
                    ),
                  ),
                  Row(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Include Saturday",
                          style: AppTextStyles.normalText.copyWith(
                            fontSize: 13,
                            color: (widget.packageDetailsData.includingSaturday == "1")
                                    ? Colors.black
                                    : Color(0xffcbc7c7),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Switch(
                        activeThumbImage: const AssetImage(
                          "assets/images/switch_on.png",
                        ),
                        inactiveThumbImage: const AssetImage(
                          "assets/images/switch_of.png",
                        ),
                        activeColor: AppConstant.appColor,
                        activeTrackColor: AppConstant.appColor,
                        inactiveTrackColor:
                            (widget.packageDetailsData.includingSaturday == "1")
                                ? Colors.black54
                                : Color(0xffcbc7c7),
                        thumbColor: MaterialStateProperty.all(Colors.white),
                        value: (widget.packageDetailsData.includingSaturday == "1")
                                ? _isSatSelected
                                : false,
                        onChanged: (value) {
                          if (widget.packageDetailsData.includingSaturday ==
                              "1") {
                            dateTimeProvider.updateIsSatSelected(value);
                            _isSatSelected = dateTimeProvider.isSatSelected;
                            _updateTileValueKey();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Include Sunday",
                          style: AppTextStyles.normalText.copyWith(
                            fontSize: 13,
                            color: (widget.packageDetailsData.includingSunday ==
                                    "1")
                                ? Colors.black
                                : Color(0xffcbc7c7),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Switch(
                        activeThumbImage: const AssetImage(
                          "assets/images/switch_on.png",
                        ),
                        inactiveThumbImage: const AssetImage(
                          "assets/images/switch_of.png",
                        ),
                        activeColor: AppConstant.appColor,
                        activeTrackColor: AppConstant.appColor,
                        inactiveTrackColor:
                            (widget.packageDetailsData.includingSunday == "1")
                                ? Colors.black54
                                : Color(0xffcbc7c7),
                        thumbColor: MaterialStateProperty.all(Colors.white),
                        value:
                            (widget.packageDetailsData.includingSunday == "1")
                                ? _isSunSelected
                                : false,
                        onChanged: (value) {
                          if (widget.packageDetailsData.includingSunday ==
                              "1") {
                            dateTimeProvider.updateIsSunSelected(value);
                            _isSunSelected = dateTimeProvider.isSunSelected;
                            _updateTileValueKey();
                          }
                        },
                      ),
                    ),
                  ]),
                  Container(

                    decoration: BoxDecoration(
                      border:isRed? Border.all(color: Colors.red,width: 2,):Border.all(color: Colors.white,width: 0,),
                      borderRadius:isRed? BorderRadius.circular(8):BorderRadius.circular(0)
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Set the border radius here
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Container(
                          height: 110,
                          width: double.infinity,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Select time for delivery",
                                    style: AppTextStyles.normalText.copyWith(
                                      color: isRed?Colors.red:Colors.black,
                                        fontSize: 15, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 1),
                                  if(isRed)
                                    SvgPicture.asset('assets/images/note_sign.svg',),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Expanded(
                                child: RawScrollbar(
                                  thumbVisibility: true,
                                  thumbColor: kYellowColor,
                                  trackColor: Colors.grey,
                                  thickness: 8,
                                  radius: const Radius.circular(20),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: GridView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: widget.packageDetailsData.deliveryTime.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5,
                                        childAspectRatio: 3,
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkResponse(
                                          onTap: () {
                                            if (Helper.isOrderTimeValid(
                                                time: widget.packageDetailsData.deliveryTime[index].fromTime,
                                                date: initialSelectedDate,
                                                context: context)) {
                                              dateTimeProvider.updateTime(
                                                  widget.packageDetailsData.deliveryTime[index].time
                                              );

                                              _selectedTime = dateTimeProvider.selectedTime;
                                              _selectedFromTime = widget.packageDetailsData.deliveryTime[index].fromTime;

                                            }

                                          },
                                          child: Container(
                                            height: 10,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 7, vertical: 3),
                                            decoration: BoxDecoration(
                                                color: _selectedTime == widget.packageDetailsData.deliveryTime[index].time
                                                    ? kYellowColor
                                                    : Colors.white,
                                                border: Border.all(
                                                    color: Colors.black26)),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                widget.packageDetailsData
                                                    .deliveryTime[index].time,
                                                maxLines: 1,
                                                style: AppTextStyles.normalText.copyWith(
                                                    fontSize: 14,
                                                    color: Helper.isOrderTimeValid(
                                                            time: widget
                                                                .packageDetailsData
                                                                .deliveryTime[
                                                                    index]
                                                                .fromTime,
                                                            context: context,
                                                            date:
                                                                initialSelectedDate)
                                                        ? Colors.black
                                                        : Colors.grey),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        Text(
                          "Select dates for delivery",
                          style: AppTextStyles.normalText.copyWith(
                              color: isRed?Colors.red:Colors.black,
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        if(isRed)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SvgPicture.asset('assets/images/note_sign.svg',),
                          ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(3)),
                            ),
                            /*const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                        ),*/
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Kitchen is closed",
                              style: AppTextStyles.normalText.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  (isLoading)
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppConstant.appColor,
                          ),
                        )
                      : Container(
                    decoration: BoxDecoration(
                        border:isRed? Border.all(color: Colors.red,width: 2,):Border.all(color: Colors.white,width: 0,),
                        borderRadius:isRed? BorderRadius.circular(8):BorderRadius.circular(0)
                    ),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Set the border radius here
                            ),
                            elevation: 4,
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.32,
                                  width: double.infinity,
                                  child: SfDateRangePicker(
                                    showNavigationArrow: true,
                                    key: ValueKey(_valueKey),
                                    rangeTextStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppConstant.fontRegular,
                                    ),
                                    startRangeSelectionColor:
                                        AppConstant.appColor,
                                    endRangeSelectionColor: AppConstant.appColor,
                                    rangeSelectionColor: AppConstant.appColor,
                                    selectionColor: AppConstant.appColor,
                                    todayHighlightColor: AppConstant.appColor,
                                    controller: controller,
                                    initialSelectedDate: controller.selectedDate,
                                    initialDisplayDate: controller.selectedDate,
                                    selectionTextStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppConstant.fontRegular,
                                        fontSize: 16),
                                    enablePastDates: false,
                                    monthCellStyle: const DateRangePickerMonthCellStyle(
                                        /*blackoutDatesDecoration: BoxDecoration(
                                      color: Colors.red,
                                      border: Border.all(
                                          color: const Color(0xFFF44436), width: 1),
                                      shape: BoxShape.circle),*/
                                        blackoutDateTextStyle: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                            // decoration: TextDecoration.lineThrough,
                                            fontSize: 12)),
                                    onSelectionChanged: _onSelectionChanged,
                                    selectionMode:
                                        DateRangePickerSelectionMode.range,
                                    // monthViewSettings: DateRangePickerMonthViewSettings(
                                    //   blackoutDates: OfflineDatesList,
                                    //   enableSwipeSelection: false,
                                    // ),
                                    monthViewSettings:
                                        DateRangePickerMonthViewSettings(
                                            firstDayOfWeek: 1,
                                            dayFormat: 'EEE',
                                            blackoutDates: OfflineDatesList,
                                            enableSwipeSelection: false,
                                            viewHeaderStyle:
                                                const DateRangePickerViewHeaderStyle(
                                                    textStyle: TextStyle())),
                                    headerStyle: const DateRangePickerHeaderStyle(
                                      textAlign: TextAlign.center,
                                    ),
                                    selectableDayPredicate:
                                        (DateTime currentDate) {
                                      bool value = dayPredicate(
                                        dateTimeProvider,
                                        currentDate,
                                        // excludeDates: offline,
                                      );
                                      return value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                  // Spacer(),

                  /* Row(
                    children: [
                      Container(
                        height: 20,width: 20,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      */ /*const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                      ),*/ /*
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Kitchen is closed",
                        style: AppTextStyles.normalText.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),*/
                  const SizedBox(
                    height: 4,
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        // "₹ ${Helper.getTotalPriceForOrderDays(
                                        //   monthlyPrice: widget
                                        //       .packageDetailsData
                                        //       .packageDetail
                                        //       .first
                                        //       .monthlyMealPrice,
                                        //   weeklyPrice: widget
                                        //       .packageDetailsData
                                        //       .packageDetail
                                        //       .first
                                        //       .weeklyMealPrice,
                                        //   mealPlan: _mealPlan,
                                        //   includingSunday: (widget
                                        //               .packageDetailsData
                                        //               .includingSunday ==
                                        //           "1")
                                        //       ? _isSunSelected
                                        //       : false,
                                        //   includingSaturday: (widget
                                        //               .packageDetailsData
                                        //               .includingSaturday ==
                                        //           "1")
                                        //       ? _isSatSelected
                                        //       : false,
                                        // )}",
                                        "₹ ${widget.packageDetailsData.price}",

                                        style: AppTextStyles.titleText.copyWith(
                                          color: kYellowColor,
                                        ),
                                      ),
                                      poppinsText(
                                        txt:
                                            '  Order for ${Helper.getTotalOrderForDays(
                                          mealPlan: _mealPlan,
                                          includingSunday: (widget
                                                      .packageDetailsData
                                                      .includingSunday ==
                                                  "1")
                                              ? _isSunSelected
                                              : false,
                                          includingSaturday: (widget
                                                      .packageDetailsData
                                                      .includingSaturday ==
                                                  "1")
                                              ? _isSatSelected
                                              : false,
                                        )}',
                                        fontSize: 17,
                                        weight: FontWeight.w600,
                                        color: kTextPrimary,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              InkResponse(
                                onTap: () async {
                                  if (_selectedTime == "") {
                                    isRed=true;
                                    setState(() {});
                                    //showDialog(
                                    //    context: context,
                                    //    builder: (context) {
                                    //      return const AlertDialog(
                                    //        title: Text(
                                    //          'Please Select tim',
                                    //          style: TextStyle(
                                    //              fontFamily:
                                    //                  AppConstant.fontRegular),
                                    //        ),
                                    //      );
                                    //    });
                                  } else if (_startDate == "" || _endDate == "") {
                                    isRed=true;
                                    setState(() {

                                    });
                                   // showDialog(context: context,
                                   //     builder: (context) {
                                   //       return const AlertDialog(
                                   //         title: Text(
                                   //           'Please Select Dates',
                                   //           style: TextStyle(
                                   //               fontFamily:
                                   //                   AppConstant.fontRegular),
                                   //         ),
                                   //       );
                                   //     });
                                  } else {
                                    final isLoggedIn =
                                        await PrefManager.getBool(
                                            AppConstant.session);

                                    if (!isLoggedIn) {
                                      List<String> selectedTime =
                                          _selectedTime.split('-');
                                      final fromTime = selectedTime[0];
                                      final toTime = selectedTime[1];

                                      var cartProvider =
                                          Provider.of<CartScreenModel>(context,
                                              listen: false);
                                      cartProvider
                                          .addToCartWithoutLogin(
                                              mealPlan: _mealPlan,
                                              kitchenId: widget.kitchenId,
                                              menuID: widget
                                                  .packageDetailsData.packageId,
                                              quantityType: '1',
                                              forSubscription: true,
                                              startDate: _startDate,
                                              endDate: _endDate,
                                              fromTime: fromTime,
                                              includeSat:
                                                  '${dateTimeProvider.isSatSelected}',
                                              includeSun:
                                                  '${dateTimeProvider.isSunSelected}',
                                              toTime: toTime)
                                          .then((value) {
                                        if (value.status!) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginWithMobileScreen()),
                                          );
                                        } else {
                                          Utils.showToast(value!.message!);
                                        }
                                      });
                                    } else {
                                      var selectDateAndTimeController =
                                          Provider.of<SelectDateAndTimeModel>(
                                              context,
                                              listen: false);
                                      Logger().f(
                                          '      package_id: ${widget.packageDetailsData.packageId},mealPlan: ${_mealPlan},includingSaturday:${dateTimeProvider.isSatSelected},includingSunday:${dateTimeProvider.isSunSelected},deliveryStartDate: ${_startDate},deliveryEndDate: ${_endDate},deliveryTime: ${_selectedTime}');

                                      selectDateAndTimeController
                                          .addCustomizedPackageDateTime(
                                              package_id: widget
                                                  .packageDetailsData.packageId,
                                              mealPlan: _mealPlan,
                                              includingSaturday:
                                                  dateTimeProvider
                                                      .isSatSelected,
                                              includingSunday: dateTimeProvider
                                                  .isSunSelected,
                                              deliveryStartDate: _startDate,
                                              deliveryEndDate: _endDate,
                                              deliveryTime: _selectedTime)
                                          .then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CustomizedSubscriptionPackageDetailsScreen(
                                              mealFor: widget.mealFor,
                                              kitchenId: widget.kitchenId,
                                              mealPlan: widget.mealPlan,
                                            ),
                                          ),
                                        );
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: kYellowColor,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Next",
                                        style:
                                            AppTextStyles.normalText.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_right_alt)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Order subscription package prior to ",
                                  style: AppTextStyles.normalText.copyWith(
                                    fontSize: 11,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.packageDetailsData
                                      .subscriptionOrderPriorTiming,
                                  style: AppTextStyles.normalText.copyWith(
                                    fontSize: 12,
                                    color: kYellowColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: " hour",
                                  style: AppTextStyles.normalText.copyWith(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
