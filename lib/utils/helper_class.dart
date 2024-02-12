import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../network/get_setting_repo.dart';
import 'constants/app_constants.dart';

class Helper {
  static String getVegNonVegText(String mealType) {
    switch (mealType) {
      case "0":
        return ("Veg");
      case "1":
        return ("Non-Veg");
      case "2":
        return ("Both Veg & Non-Veg");

      default:
        return (" ");
    }
  }

  static int getNumberOfDaysInAWeek({
    required String includingSaturday,
    required String includingSunday,
  }) {
    switch ('${includingSaturday} ${includingSunday}') {
      case "0 1":
        return 6;
      case "1 0":
        return 6;
      case "1 1":
        return 7;
      case "0 0":
        return 5;
      default:
        return 5;
    }
  }

  /// Get ItemStatus in Active Orders Tab
  static ItemStatusEnum? getItemStatus({required String itemStatus}) {
    switch (itemStatus) {
      case "Order Under Process":
        return ItemStatusEnum.underProcess;
      case "0":
        return ItemStatusEnum.readyForPickup;
      case "1":
        return ItemStatusEnum.assignedToRider;
      case "2":
        return ItemStatusEnum.startDelivery;
      case "3":
        return ItemStatusEnum.delivered;
      case "4":
        return ItemStatusEnum.cancelled;
      case "5":
        return ItemStatusEnum.pending;
      case "6":
        return ItemStatusEnum.beingPrepared;
      case "7":
        return ItemStatusEnum.rejected;
      case "8":
        return ItemStatusEnum.postponed;
      case "10":
        return ItemStatusEnum.diverted;

      default:
        return null;
    }
  }

  /// Get ItemStatus Button according to  ItemStatus in Active Orders Tab
  static Widget getItemStatusButton({required String itemStatus}) {
    switch (itemStatus) {
      case "Order Under Process":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 255, 238, 146).withOpacity(0.5),
            ),
          ),
          child: Text(
            "Under Process",
            style: TextStyle(
              fontFamily: AppConstant.fontRegular,
              color: const Color.fromARGB(255, 45, 45, 45).withOpacity(0.5),
            ),
          ),
        );
      case "0":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 142, 246, 160).withOpacity(0.7),
            ),
          ),
          child: Text(
            "Ready For Pickup",
            style: TextStyle(
              fontFamily: AppConstant.fontRegular,
              color: Color.fromARGB(255, 45, 45, 45).withOpacity(0.7),
            ),
          ),
        );
      case "1":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 178, 222, 252).withOpacity(0.7),
            ),
          ),
          child: Text(
            "Assigned to Rider",
            style: TextStyle(
              fontFamily: AppConstant.fontRegular,
              color: const Color.fromARGB(255, 45, 45, 45).withOpacity(0.7),
            ),
          ),
        );
      case "2":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 211, 252, 178).withOpacity(0.7),
            ),
          ),
          child: Text(
            "Delivery Started",
            style: TextStyle(
              fontFamily: AppConstant.fontRegular,
              color: const Color.fromARGB(255, 45, 45, 45).withOpacity(0.7),
            ),
          ),
        );
      /* case "3":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(3),
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 26, 187, 53),
            ),
          ),
          child: const Text(
            "Delivered",
            style: TextStyle(
              fontFamily: AppConstant.fontRegular,
              color: Colors.white,
            ),
          ),
        );*/
      case "4":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              Colors.redAccent.withOpacity(0.7),
            ),
          ),
          child: Text(
            "Cancelled",
            style: TextStyle(
              fontFamily: AppConstant.fontRegular,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        );
      /* case "5":
        return const Text(
          "Active",
          style: TextStyle(
            fontFamily: AppConstant.fontRegular,
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        );*/
      case "6":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 26, 187, 53).withOpacity(0.7),
            ),
          ),
          child: Text(
            "Being Prepared",
            style: TextStyle(
              fontFamily: AppConstant.fontRegular,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        );
      case "7":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xfff6876e),
            ),
          ),
          child: const Text(
            "Rejected",
            style: TextStyle(
                fontFamily: AppConstant.fontRegular,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        );
      case "8":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xfff9d683).withOpacity(0.7),
            ),
          ),
          child: Text(
            "Postponed",
            style: TextStyle(
                fontFamily: AppConstant.fontRegular,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w600),
          ),
        );
      case "10":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xfff6876e),
            ),
          ),
          child: const Text(
            "Diverted",
            style: TextStyle(
                fontFamily: AppConstant.fontRegular,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        );
      default:
        return SizedBox();
    }
  }

  static int convertStringToDoubleAndRemoveDecimal(String inputString) {
    double inputValue = double.parse(inputString);
    int intValue = inputValue.toInt();
    return intValue;
  }

  static String shareKitchenContent(String kitchenDetailsID) {
    return "Hey there! \u{1F44B}\u{200D}\u{1F468} Discover this amazing kitchen where they whip up the most rad and delicious food! \u{1F354}\u{1F468}\u{200D}\u{1F373} You won't believe the awesome flavors they create! \u{2B50} Don't miss out on this culinary adventure! \u{1F957}\u{1F32E} \n https://nohungtest.tech/kitchen-detail/$kitchenDetailsID";
  }

  static String shareKitchenPackageContent(
      String kitchenDetailsID, String packageID) {
    return "Hey there! \u{1F44B}\u{200D}\u{1F468} Discover this amazing kitchen where they whip up the most rad and delicious food! \u{1F354}\u{1F468}\u{200D}\u{1F373} You won't believe the awesome flavors they create! \u{2B50} Don't miss out on this culinary adventure! \u{1F957}\u{1F32E} \n https://nohungtest.tech/kitchen-detail/$kitchenDetailsID/subscription-$packageID";
  }

  static String shareAppContent() {
    return "Hey Foodie! \u{1F354}\u{1F35F} Explore a galaxy of kitchens where culinary magic happens! Our talented chefs across various kitchens whip up dishes that will leave you craving for more! \u{1F35D}\u{1F373} Experience an explosion of flavors that will tantalize your taste buds! \u{2728} Don't wait, embark on this epicurean journey now! \u{1F37F} #SavorDelivered 📲👌";
  }

  // get mealFor initials
  static String mealForInitials(String mealFor) {
    switch (mealFor) {
      case "Breakfast":
        return ("BF");
      case "Lunch":
        return ("L");
      case "Dinner":
        return ("D");

      default:
        return (" ");
    }
  }

  static String getMealsInAWeek({
    required String includingSaturday,
    required String includingSunday,
  }) {
    switch ('${includingSaturday} ${includingSunday}') {
      case "0 1":
        return ("6 Meals/Week");
      case "1 0":
        return ("6 Meals/Week");
      case "1 1":
        return ("7 Meals/Week");
      case "0 0":
        return ("5 Meals/Week");
      default:
        return (" ");
    }
  }

  static String getIncludesSatSun({
    required String includingSaturday,
    required String includingSunday,
  }) {
    switch ('${includingSaturday} ${includingSunday}') {
      case "0 1":
        return ("(Includes Sun)");
      case "1 0":
        return ("(Includes Sat)");
      case "1 1":
        return ("(Includes Sat/Sun)");
      case "0 0":
        return ("");
      default:
        return ("");
    }
  }

  static String getTotalOrderForDays({
    required String mealPlan,
    required bool includingSunday,
    required bool includingSaturday,
  }) {
    if (mealPlan == 'weekly' && includingSunday && includingSaturday) {
      return "7 Days";
    } else if (mealPlan == 'weekly' && !includingSunday && includingSaturday) {
      return "6 Days";
    } else if (mealPlan == 'weekly' && includingSunday && !includingSaturday) {
      return "6 Days";
    } else if (mealPlan == 'weekly' && !includingSunday && !includingSaturday) {
      return "5 Days";
    } else if (mealPlan == 'monthly' && includingSunday && includingSaturday) {
      return "30 Days";
    } else if (mealPlan == 'monthly' && !includingSunday && includingSaturday) {
      return "26 Days";
    } else if (mealPlan == 'monthly' && includingSunday && !includingSaturday) {
      return "26 Days";
    } else if (mealPlan == 'monthly' &&
        !includingSunday &&
        !includingSaturday) {
      return "22 Days";
    }
    return "";
  }

  static String roundToTensAndRound(double value) {
    double newValue = value * 10;
    int roundedValue = newValue.ceil();
    double finalValue = roundedValue / 10;
    return finalValue.toStringAsFixed(0);
  }

  static String getTotalPriceForOrderDays({
    required String mealPlan,
    required bool includingSunday,
    required bool includingSaturday,
    required double weeklyPrice,
    required double monthlyPrice,
  }) {
    if (mealPlan == 'weekly' && includingSunday && includingSaturday) {
      return roundToTensAndRound(7 * weeklyPrice);
    } else if (mealPlan == 'weekly' && !includingSunday && includingSaturday) {
      return roundToTensAndRound(6 * weeklyPrice);
    } else if (mealPlan == 'weekly' && includingSunday && !includingSaturday) {
      return roundToTensAndRound(6 * weeklyPrice);
    } else if (mealPlan == 'weekly' && !includingSunday && !includingSaturday) {
      return roundToTensAndRound(5 * weeklyPrice);
    } else if (mealPlan == 'monthly' && includingSunday && includingSaturday) {
      return roundToTensAndRound(30 * monthlyPrice);
    } else if (mealPlan == 'monthly' && !includingSunday && includingSaturday) {
      return roundToTensAndRound(26 * monthlyPrice);
    } else if (mealPlan == 'monthly' && includingSunday && !includingSaturday) {
      return roundToTensAndRound(26 * monthlyPrice);
    } else if (mealPlan == 'monthly' &&
        !includingSunday &&
        !includingSaturday) {
      return roundToTensAndRound(22 * monthlyPrice);
    }
    return '';
  }

  static bool isOrderTimeValid(
      {required String time,
      required DateTime date,
      required BuildContext context}) {
    final settingProvider =
        Provider.of<GetSettingModel>(context, listen: false);
    final subscriptionPriorTiming =
        settingProvider.subscription_order_prior_timing;
    print('nikhil setSubscriptionPriorTiming ${subscriptionPriorTiming}');

    print('nikhil setSubscriptionPriorTiming timeeeeeeeeee ${time}');

// Convert the string to a DateTime object
    if (time.isEmpty) {
      return true;
    } else {
      List<String> parts = time.split(':');
      DateTime dateTimeX = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, int.parse(parts[0]), int.parse(parts[1]));

      // Calculate current time plus one hour
      DateTime oneHourLater = DateTime.now()
          .add(Duration(hours: int.parse(subscriptionPriorTiming)));

      // Compare with one hour later
      if (dateTimeX.isAfter(oneHourLater)) {
        print(' is greater than current time plus one hour');
        return true;
      } else if (DateTime.now().year == date.year &&
          DateTime.now().month == date.month &&
          DateTime.now().day == date.day) {
        print(' is not greater than current time plus');

        return false;
      } else {
        print(
            ' is not greater than current time plus one hour but date is not today');
        return true;
      }
    }
  }

  static String getMealTypeImage(String mealType) {
    switch (mealType) {
      case "0":
        return ('assets/images/leaf.svg');
      case "1":
        return ('assets/images/chicken.svg');
      case "2":
        return ('assets/images/both.svg');
      default:
        return (" ");
    }
  }

  static String formatTime(String inputTime) {
    DateFormat inputFormat = DateFormat("HH:mm:ss");
    DateFormat outputFormat = DateFormat("hh:mm a");

    DateTime dateTime = inputFormat.parse(inputTime);
    String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

  static String formatDateFromString(String inputDate) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd");
    DateFormat outputFormat = DateFormat("EEEE, MMM d");

    DateTime dateTime = inputFormat.parse(inputDate);
    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }

  static String formatInvoiceDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('d MMM y, hh:mm a').format(dateTime);
    return formattedDate;
  }

  static String formatDateFromDateTime(DateTime inputDate) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    String formattedDate = dateFormat.format(inputDate);

    return formattedDate;
  }

  static String extractDaysSubstringInInvoice(String input) {
    int startIndex = input.indexOf("(") + 1;
    int endIndex = input.indexOf(")", startIndex);

    if (startIndex >= 0 && endIndex >= 0) {
      final finalString = input.substring(startIndex, endIndex);
      return "($finalString)";
    } else {
      return '';
    }
  }

  static String formattedDateTime(DateTime x) =>
      DateFormat('E, d MMM').format(x);

  static String getDiscountPercentOrFlat(String discount) {
    switch (discount) {
      case "1":
        return ("flat");
      case "0":
        return ("%");

      default:
        return (" ");
    }
  }

  /// Find out the order history status based on status number
  static String getOrderHistoryStatus(
      {required String status, required String orderType}) {
    switch ('${status} ${orderType}') {
      case "2 package":
        return ("Order Rejected");
      case "2 trial":
        return ("Order Rejected");
      /* case "6 trial":
        return ("Completed");*/
      case "7 package":
        return ("Subscription Cancelled");
      case "7 trial":
        return ("Cancelled");
      case "8 package":
        return ("Subscription Postponed");

      default:
        return (" ");
    }
  }

  /// Get MealFor Name based on Number
  static String getMealForList(String value) {
    List<String> numbers = value.split(',');
    List<String> output = [];

    for (String number in numbers) {
      if (number == '0') {
        output.add('Breakfast');
      } else if (number == '1') {
        output.add('Lunch');
      } else if (number == '2') {
        output.add('Dinner');
      }
    }

    return output.join(',');
  }

  /// Get Cuisine Name based on Number
  static String getCuisineName(String number) {
    switch (number) {
      case "0":
        return ("South Indian");
      case "1":
        return ("North Indian");
      case "2":
        return ("Other Cuisine");

      default:
        return ("");
    }
  }
}
