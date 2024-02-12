import 'package:flutter/material.dart';

import '../../model/destination.dart';
import '../../presentation/screen/Cart/cart_screen.dart';
import '../../presentation/screen/Profile/profile.dart';
import '../../presentation/screen/home_screen/home_screen.dart';
import '../../presentation/screen/order_screen.dart';

class AuthNotifier extends ChangeNotifier {
  String verificationCode = "";
}

const String UserBoxName = "UserBoxName";
const String UserKey = "userKey";

class AppConstant {
  /// Shared Preferences Constants

  static const spPackageDetails = 'packageDetails';
  static const spMealPlan = 'mealPlan';
  static const spSubscriptionPriorTiming = 'subscriptionPriorTiming';

  static const fontRegular = 'productsans_regular';
  static const fontBold = 'productsans_bold';
  static const dollar = '\$';
  static const rupee = '₹';
  static const lang = "lang";
  static const appColor = Color(0xffFBBB00);
  static const appColo = Color(0xff2F3443);

  static const lightGreen = Color(0xff7EDABF);
  static const userProfile = "userProfile";
  static const session = "session";
  static const httpBase = 'https://';
  static const placesApiKey = 'AIzaSyCYwdySyPeWE0Mc0iV6tedJOULAHvk6u4s';
  static const razorPayBaseUrl = 'https://api.razorpay.com';
  static const _razorpay_secret = 'OcZrdxGWO3B4MgU4ky3R7HMo';
  static const _razorpay_key_id = 'rzp_test_7YQOfHs3FUty8J';
  static get razorpay_secret => _razorpay_secret;
  static get razorpay_key_id => _razorpay_key_id;

  final Uri privacyPolicyUrl =
      Uri.parse('https://nohung.com/manage-content/privacy-policy');
  final Uri termsAndConditionsUrl =
      Uri.parse('https://nohung.com/manage-content/terms-and-conditions');
  static const imageUrl =
      "https://nohungkitchen.notionprojects.tech/assets/uploaded/customer/";
  static const menuUrl =
      "https://nohungkitchen.notionprojects.tech/assets/uploaded/menu/";
  static const document =
      "https://nohungkitchen.notionprojects.tech/assets/uploaded/document/";
}

/// ENUM FOR MEAL FOR CONSTANTS
enum MealForEnum {
  breakfast("0"),
  lunch("1"),
  dinner("2");

  const MealForEnum(this.value);
  final String value;
}

/// ENUM ITEM STATUS
enum ItemStatusEnum {
  underProcess,
  assignedToRider,
  startDelivery,
  diverted,
  readyForPickup,
  delivered,
  cancelled,
  pending,
  beingPrepared,
  rejected,
  postponed,
}

const black1 = Color(0xff2F3443);
const botmColor = Color(0xff2F3443);
const String SaveUserData = 'User';
const String UsersKey = 'userKey';

const String KitchensBox = 'KitchensBox';
const String KitchenKey = 'kitchenKey';

final allDestinations = <Destination>[
  Destination(
      id: 1,
      iconPath: "assets/images/home.svg",
      name: "Home",
      child: const HomeScreen(
        fromHome: false,
        mealFor: '',
      )),
  Destination(
      id: 2,
      name: 'Orders',
      iconPath: 'assets/images/home.svg',
      child: const OrderScreen()),
  Destination(
      id: 3,
      name: "Cart",
      iconPath: "assets/images/home.svg",
      child: const CartScreen()),
  Destination(
      id: 4,
      name: "Profile",
      iconPath: "assets/images/home.svg",
      child: const Profile())
];

enum MealFilter {
  veg,
  nonVeg,
  vegNonVeg,
}

enum CuisineFilter {
  northIndian,
  southIndian,
  dietMeals,
  otherMeals,
}

class MealType {
  final String name;
  final String icon;

  const MealType({
    required this.name,
    required this.icon,
  });
}

List<MealType> mealTypeListWithImage = [
  const MealType(icon: "assets/images/leaf.svg", name: "Veg"),
  const MealType(icon: "assets/images/chicken.svg", name: "Non-Veg"),
  const MealType(icon: "assets/images/both.svg", name: "Veg/Non-Veg"),
];
List cuisineTypeList = [
  "North Indian",
  "South Indian",
  "Diet Meals",
  "Other Meals"
];
List mealPlanList = [
  "Weekly",
  "Monthly",
  "Pre Order",
];

List mealForList = [
  "Breakfast",
  "Lunch",
  "Dinner",
];
List cuisineList = [
  "South Indian",
  "North Indian",
  "Other Cuisine",
];
