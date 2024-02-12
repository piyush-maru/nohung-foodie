import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/get_home_data.dart' as home;
import 'package:food_app/model/home_screen_model/home_screen_model.dart';
import 'package:food_app/network/home_screen_repo/home_screen_search.dart';
import 'package:food_app/presentation/screen/home_filter/home_filter_screen.dart';
import 'package:food_app/presentation/screen/home_screen/search_main_screen.dart';
import 'package:food_app/presentation/screen/home_screen/widgets/kitchen_details_home_screen_card.dart';
import 'package:food_app/presentation/screen/home_screen/widgets/top_package_details_card.dart';
import 'package:food_app/presentation/screen/location_collections/address_list_screen.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/Dimens.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../model/cart_count_provider/cart_count_provider.dart';
import '../../../model/cuisine_types_model/cuisine_types_model.dart';
import '../../../model/cuisine_types_provider/cuisine_types_provider.dart';
import '../../../model/home_screen_model/top_packages_model.dart';
import '../../../network/fav_kitchen_repo/fav_kitchen_model.dart';
import '../../../network/home_screen_repo/home_screen_api_controller.dart';
import '../../../network/pre_order/pre_order_provider.dart';
import '../../../network/user/user_address_model.dart';
import '../../../providers/address_location_provider.dart';
import '../../../utils/Utils.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../../utils/push_notification.dart';
import '../../../utils/size_config.dart';
import '../../widgets/jumping_dots/dancing_dots.dart';
import '../../widgets/shimmer_container.dart';
import '../location_collections/widgets/add_edit_address_bottomsheet.dart';
import '../top_packages_view_all/top_packages_view_all_screen.dart';
import 'kitchen_categories.dart';

class HomeScreen extends StatefulWidget {
  final String mealFor;
  final String cuisine;
  final String mealType;
  final double min;
  final double max;
  final String mealPlan;
  final bool skip;
  final bool fromHome;

  const HomeScreen(
      {Key? key,
      required this.mealFor,
      required this.fromHome,
      this.cuisine = '',
      this.mealPlan = '',
      this.mealType = '',
      this.min = 0.0,
      this.max = 0.0,
      this.skip = false})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<TopPackagesData>>? topPackagesFuture;
  Future<CuisineTypesModel>? getAllCuisineTypesFuture;

  home.Data? result;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  Logger log = Logger();
  var mealsTypeTemp = [];
  var mealTypeImages = [
   'assets/images/Breakf.png',
   'assets/images/Lunc.png',
   'assets/images/diner.png',
  ];
  var mealsType = ["Breakfast", "Lunch", "Dinner"];
  Future<HomeKitchen>? kitchenListFuture;

  final CarouselController carouselController = CarouselController();
  getCartCount() async {
    final preOrderProvider = Provider.of<PreorderProvider>(context);

    Provider.of<CartCountModel>(context, listen: false)
        .checkCartCount(provider: preOrderProvider);
  }

  var isFav = false;
  int index = 0;
  bool canPop = true;

  int sIndex = 0;
  DateTime? currentBackPressTime;

  int selectedIndex = 1;
  List<String> dataList = [];
  List<String> firstThreeData = [];
  late bool isSkip;
  Timer? timer;
  List<String> mySlide = [
   //"assets/images/slide_image2.png",
   //"assets/images/slide_image3.jpeg",
   //"assets/images/slide_image2.png",
   //"assets/images/slide_image4.jpeg",
   "assets/images/banner_of1.jpg",
   "assets/images/banner_of2.jpg",
   "assets/images/banner_of3.jpg",
   // "assets/images/slide_image2.png",
  ];
  /*var mySlide = [
    "assets/images/slide_image2.jpg",
    "assets/images/slide_image3.jpeg",
    "assets/images/slide_image2.jpg",
    "assets/images/slide_image4.jpeg",
    "assets/images/slide_image2.jpg",
    //"assets/images/slide_image5.jpeg",
    //"assets/images/slide_image6.jpeg",
    // "assets/images/Offers_banner.jpg",
  ];*/

  var crosuealItems = [
    'https://images.pexels.com/photos/4393021/pexels-photo-4393021.jpeg',
    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618575517942/food-coupons.jpg",
    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618575517942/food-coupons.jpg",
    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618575517942/food-coupons.jpg",
    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618575517942/food-coupons.jpg",
    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618575517942/food-coupons.jpg",
    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618575517942/food-coupons.jpg",
    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618575517942/food-coupons.jpg",
    "https://cdn.grabon.in/gograbon/images/web-images/uploads/1618575517942/food-coupons.jpg",
  ];
  final TextEditingController _searchController = TextEditingController();
  Timer? timer1;
  int _currentHintIndex = 0;
  final List<String> _hintTexts = [
    'Search "North Indian"',
    'Search "South Indian"',
    'Search "Jain"',
    'Search "Diet meals"',
  ];
  int slideIndex = 0;
  final searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    PushNotification().init(context);

    _startTimer();
    getCartCount();
    final homeKitchenData =
        Provider.of<HomeScreenProvider>(context, listen: false);
    final cuisineTypesProvider =
        Provider.of<CuisineTypesProvider>(context, listen: false);
    topPackagesFuture = homeKitchenData.getTopPackages(
        mealForFilter: "", mealTypeFilter: "", cuisineFilter: "");
    getAllCuisineTypesFuture = cuisineTypesProvider.getAllCuisineTypes();
    kitchenListFuture = homeKitchenData.getHomeScreenData(
      mealFor: "",
      mealType: "",
      maxPrice: "",
      minPrice: "",
      rating: "",
      cuisineType: "",
      mealPlan: "",
      customerLatitude: "17.4431103",
      customerLongitude: "78.3869877",
    );

    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    _searchController.text = _lastWords;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SearchMain(searchText: _searchController.text),
      ),
    );
  }

  void apiCalls() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await Provider.of<HomeScreenProvider>(context, listen: false)
        .getAddressFromLatLong(position, position.latitude, position.longitude);
  }

  @override
  void dispose() {
    timer1?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _startTimer() {
    timer1 = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentHintIndex = (_currentHintIndex + 1) % _hintTexts.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationAddressProvider =
        Provider.of<AddressLocationProvider>(context, listen: true);
    final userAddressModel =
        Provider.of<UserAddressModel>(context, listen: true);
    var homeKitchenData =
        Provider.of<HomeScreenProvider>(context, listen: false);
    final favKitchenModel =
        Provider.of<FavKitchenModel>(context, listen: false);
    final searchModel =
        Provider.of<SearchHomeScreenModel>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Utils.showToast("Swipe back again to close app");
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 220,
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressListScreen()),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: Image.asset(
                      Res.location,
                      width: 30,
                      height: 30,
                      color: AppConstant.appColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            locationAddressProvider.getArea.isNotEmpty
                                ? locationAddressProvider.getArea
                                : userAddressModel.getAddressType,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppConstant.fontRegular,
                                fontSize: SizeConfig.defaultSize! *
                                    Dimens.size1Point8,
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Image.asset(
                              Res.downArrow,
                              height: SizeConfig.defaultSize! * Dimens.size2,
                              width: SizeConfig.defaultSize! * Dimens.size2,
                            ),
                          )
                        ],
                      ),
                      FittedBox(
                        child: Text(
                          locationAddressProvider.getAddress.isNotEmpty
                              ? locationAddressProvider.getAddress.length > 30
                                  ? '${locationAddressProvider.getAddress.substring(0, 30)}...'
                                  : locationAddressProvider.getAddress
                              : userAddressModel.getAddress.length > 30
                                  ? '${userAddressModel.getAddress.substring(0, 30)}...'
                                  : userAddressModel.getAddress,
                          // homeKitchenData.address ?? 'Address',
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                              fontFamily: AppConstant.fontRegular,
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        /*  title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(50.0), // Set the border radius here
                ),
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()),
                    );
                  },
                  child: Container(
                    height: SizeConfig.defaultSize! * Dimens.size4,
                    width: SizeConfig.defaultSize! * Dimens.size4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.defaultSize! * Dimens.size5),
                      ),
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: AppConstant.appColor,
                    ),
                  ),
                ),
              ),
            ],
          ),*/
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      // top: SizeConfig.defaultSize! * Dimens.size1,
                      left: SizeConfig.defaultSize! * Dimens.size1,
                      right: SizeConfig.defaultSize! * Dimens.size1,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.black45,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SearchMain(),
                                  ),
                                );
                              },
                              decoration: InputDecoration(
                                hintText: _hintTexts[
                                    _currentHintIndex], //"Search North Indian, South Indian, Jain, Diet meals",
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: const EdgeInsets.only(
                                  left: 4,
                                  right: 4,
                                  bottom: 7,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.search,
                            color: Color(0xb5232323),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 6),
                            child: Container(
                              width: 0.5,
                              height: 24,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_speechToText.isNotListening) {
                                showModalBottomSheet(
                                  enableDrag: true,
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25))),
                                  context: context,
                                  builder: (context) => WillPopScope(
                                    onWillPop: () async {
                                      return false;
                                    },
                                    child: SingleChildScrollView(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: SingleChildScrollView(
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 30),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Hi, I'm listening.\nWhat do you like to eat ?",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppTextStyles
                                                            .semiBoldText,
                                                      ),
                                                      const SizedBox(
                                                        height: 25,
                                                      ),
                                                      const CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              kYellowColor,
                                                          child: Icon(
                                                            Icons.mic,
                                                            color: Colors.white,
                                                            size: 35,
                                                          )),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      const JumpingDots(
                                                        color: kYellowColor,
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          )),
                                    ),
                                  ),
                                );
                              }
                              Future.delayed(const Duration(seconds: 5), () {
                                if (canPop) {
                                  Navigator.pop(context);
                                  _stopListening();
                                }
                              });

                              _speechToText.isNotListening
                                  ? _startListening()
                                  : _stopListening();
                            },
                            child: _speechToText.isNotListening
                                ? const Icon(
                                    Icons.mic,
                                    color: Color(0xb5232323),
                                  )
                                : const JumpingDots(
                                    height: 3,
                                    width: 2,
                                    color: kYellowColor,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {},
                    child: CarouselSlider(
                      options: CarouselOptions(
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          disableCenter: true,
                          // aspectRatio: 2.4,
                          viewportFraction: 0.84, //0.85,
                          onPageChanged: (val, _) {
                            setState(() {
                              sIndex = val;
                            });
                          },
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlay: true,
                          height: 140.0,
                          autoPlayCurve: Curves.fastOutSlowIn),
                      items: mySlide.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Image.asset(
                              i.toString(),
                              /*width: 280,height: 200,*/ fit: BoxFit.fill,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  DotBar(
                    numberOfDots: mySlide.length,
                    currentDotIndex:
                        sIndex, // Highlight the third dot (0-based index)
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        poppinsText(
                            txt: "Start Daily Meal Subscription",
                            maxLines: 3,
                            fontSize: 16,
                            textAlign: TextAlign.center,
                            weight: FontWeight.w500),
                        const SizedBox(height: 10),
                        FutureBuilder<CuisineTypesModel>(
                            future: getAllCuisineTypesFuture,
                            builder: (context, cuisineSnapshot) {
                              if (cuisineSnapshot.hasError) {
                                debugPrint(
                                    '--${cuisineSnapshot.error.toString()}');
                              }
                              if (cuisineSnapshot.hasData) {
                                return InkResponse(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeFiltersScreen(
                                            cuisineTypes:
                                                cuisineSnapshot.data!),
                                      ),
                                    ).then((result) {
                                      topPackagesFuture =
                                          homeKitchenData.getTopPackages(
                                        mealForFilter:
                                            homeKitchenData.mealForPackage,
                                        mealTypeFilter:
                                            homeKitchenData.mealType,
                                        cuisineFilter:
                                            homeKitchenData.cuisineName,
                                      );

                                      kitchenListFuture =
                                          homeKitchenData.getHomeScreenData(
                                        mealFor: homeKitchenData.mealFor,
                                        mealType: homeKitchenData.mealType,
                                        maxPrice: "",
                                        minPrice: "",
                                        rating: "",
                                        cuisineType: homeKitchenData.cuisine,
                                        mealPlan: homeKitchenData.mealPlan,
                                        customerLatitude: "17.4431103",
                                        customerLongitude: "78.3869877",
                                      );
                                      setState(() {});
                                    });
                                  },
                                  child: const Image(
                                    image: AssetImage(
                                        "assets/images/filters1.png"),
                                    height: 30,
                                    width: 30,
                                  ),
                                );
                              }
                              return const Image(
                                image: AssetImage("assets/images/filters1.png"),
                                height: 30,
                                width: 30,
                              );
                            }),
                      ]),
                  SizedBox(
                    height: SizeConfig.defaultSize! * Dimens.size12Point5,
                    width: SizeConfig.defaultSize! * Dimens.size40,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: mealsType.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (mealsTypeTemp.contains(mealsType[i])) {
                                  mealsTypeTemp.remove(mealsType[i]);
                                } else {
                                  mealsTypeTemp.add(mealsType[i]);
                                }
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left:
                                    SizeConfig.defaultSize! * Dimens.sizePoint8,
                                right:
                                    SizeConfig.defaultSize! * Dimens.sizePoint6,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KitchenCategories(
                                        mealFor: i == 0
                                            ? "0"
                                            : i == 1
                                                ? "1"
                                                : "2",
                                        mealFors: i == 0
                                            ? "Breakfast"
                                            : i == 1
                                                ? "Lunch"
                                                : "Dinner",
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.defaultSize! * Dimens.size2),
                                  ),
                                  child: Container(
                                    height: SizeConfig.defaultSize! * Dimens.size5,
                                    width: SizeConfig.defaultSize! * Dimens.size11,
                                    decoration: BoxDecoration(
                                      color: mealsTypeTemp.contains(mealsType[i])
                                              ? AppConstant.appColor
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(SizeConfig.defaultSize! * Dimens.size2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(height: 8,),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0.0),
                                          child: Image.asset(
                                            mealTypeImages[i].toString(),
                                            height: 60,
                                            width: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: SizeConfig.defaultSize! *
                                                Dimens.size1,
                                            right: SizeConfig.defaultSize! *
                                                Dimens.size1,
                                            bottom: SizeConfig.defaultSize! *
                                                Dimens.size1,
                                          ),
                                          child: Text(
                                            mealsType[i],
                                            style: TextStyle(
                                              color: mealsTypeTemp
                                                      .contains(mealsType[i])
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize:
                                                  SizeConfig.defaultSize! *
                                                      Dimens.size1Point8,
                                              fontWeight: FontWeight.w400,
                                              fontFamily:
                                                  AppConstant.fontRegular,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      poppinsText(
                          txt: "Top Package's",
                          maxLines: 3,
                          fontSize: 16,
                          textAlign: TextAlign.center,
                          weight: FontWeight.w500),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TopPackageViewAllScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "View all",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<List<TopPackagesData>>(
                      future: topPackagesFuture,
                      builder: (context, packageSnapshot) {
                        if (packageSnapshot.hasError) {
                          debugPrint('--${packageSnapshot.error.toString()}');
                        }

                        return packageSnapshot.hasData
                            ? packageSnapshot.data!.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 50),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/image_no_orders.png',
                                            height: 200,
                                          ),
                                          poppinsText(
                                              txt:
                                                  "No such packages are available",
                                              fontSize: 16,
                                              textAlign: TextAlign.center,
                                              weight: FontWeight.w500),
                                        ],
                                      ),
                                    ),
                                  )
                                : CarouselSlider(
                                    carouselController: carouselController,
                                    items: packageSnapshot.data!.map((package) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return TopPackagesDetailsCardCarousel(
                                            package: package,
                                          );
                                        },
                                      );
                                    }).toList(),
                                    options: CarouselOptions(
                                      enableInfiniteScroll: false,
                                      viewportFraction: 0.91,
                                      autoPlay: true,
                                      height: 200,
                                    ),
                                  )
                            : Shimmer.fromColors(
                                baseColor: const Color(0xd2eeecec),
                                highlightColor: const Color(0xd2fdfbfb),
                                child: const ShimmerContainer(
                                  height: 200,
                                  width: double.infinity,
                                ),
                              );
                      }),
                  FutureBuilder<HomeKitchen>(
                      future: kitchenListFuture,
                      builder: (context, snapshot) {
                        return  snapshot.data != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  poppinsText(
                                      txt: "Kitchen's Near You",
                                      maxLines: 3,
                                      fontSize: 16,
                                      textAlign: TextAlign.center,
                                      weight: FontWeight.w500),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  snapshot.data!.data.isEmpty
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 50),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/image_no_orders.png',
                                                  height: 200,
                                                ),
                                                poppinsText(
                                                    txt:
                                                        "No such Kitchens are available",
                                                    fontSize: 16,
                                                    textAlign: TextAlign.center,
                                                    weight: FontWeight.w500),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(
                                          child: ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data!.data.length,
                                              itemBuilder: (context, index) {
                                                return KitchenDetailsHomeScreenCard(
                                                  snapshot: snapshot
                                                      .data!.data![index],
                                                );
                                              }),
                                        ),
                                ],
                              )
                            : Shimmer.fromColors(
                                baseColor: const Color(0xd2eeecec),
                                highlightColor: const Color(0xd2fdfbfb),
                                child: const ShimmerContainer(
                                  height: 200,
                                  width: double.infinity,
                                ),
                              );
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}

class DotBar extends StatelessWidget {
  final int numberOfDots;
  final int currentDotIndex;

  DotBar({required this.numberOfDots, required this.currentDotIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numberOfDots,
        (index) => Dot(
          isActive: index == currentDotIndex,
          sInd: currentDotIndex + 1,
          itemLength: numberOfDots.toString(),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool isActive;
  final double size = 8; //8.5
  final int sInd;
  final String itemLength;

  Dot({required this.isActive, required this.sInd, required this.itemLength});

  @override
  Widget build(BuildContext context) {
    return isActive
        ? Container(
            margin: const EdgeInsets.all(1.0),
            width: 30,
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black87.withOpacity(0.7),
            ),
            child: Center(
              child: poppinsText(
                  color: Colors.white,
                  txt: "${sInd.toString()}/${itemLength.toString()} ",
                  fontSize: 9,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w600),
            ),
          )
        : Container(
            margin: const EdgeInsets.all(3.0),
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.9), // Border color
                width: 0.50, // Border width
              ),
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          );
  }
}

/*Container(
      margin: const EdgeInsets.all(1.0),
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive?Colors.black:Colors.grey, // Border color
          width: 0.50, // Border width
        ),
        shape: BoxShape.circle,
        color: isActive ? Colors.black : Colors.white,
      ),
    );*/
