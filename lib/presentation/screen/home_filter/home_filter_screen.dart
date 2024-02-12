import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../model/cuisine_types_model/cuisine_types_model.dart';
import '../../../network/home_screen_repo/home_screen_api_controller.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/ui_constants.dart';

class HomeFiltersScreen extends StatefulWidget {
  const HomeFiltersScreen({Key? key, required this.cuisineTypes})
      : super(key: key);
  final CuisineTypesModel cuisineTypes;
  @override
  _HomeFiltersScreenState createState() => _HomeFiltersScreenState();
}

class _HomeFiltersScreenState extends State<HomeFiltersScreen> {
  List<String> mealFor = [];
  int? mealType;
  List<String> cuisine = [];
  List<String> cuisineName = [];
  List<String> mealPlan = [];
  RangeValues currentRangeValues = const RangeValues(0, 1000);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      var homeScreenProvider = Provider.of<HomeScreenProvider>(
        context,
        listen: false, // Set to false to prevent rebuilds on change
      );

      setState(() {
        cuisineName = homeScreenProvider.cuisineName.isEmpty
            ? []
            : homeScreenProvider.cuisineName.split(',');
        mealFor = homeScreenProvider.mealFor.isEmpty
            ? []
            : homeScreenProvider.mealFor.split(',');
        mealType = homeScreenProvider.mealType.isEmpty
            ? -1
            : int.parse(homeScreenProvider.mealType);
        cuisine = homeScreenProvider.cuisine.isEmpty
            ? []
            : homeScreenProvider.cuisine.split(',');
        mealPlan = homeScreenProvider.mealPlan.isEmpty
            ? []
            : homeScreenProvider.mealPlan.split(',');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var homeScreenProvider = Provider.of<HomeScreenProvider>(
      context,
    );

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(
                              "assets/images/backyellowbutton.png",
                              height: 28)),
                      const SizedBox(width: 8),
                      poppinsText(
                          maxLines: 3,
                          txt: "Filters",
                          fontSize: 18,
                          textAlign: TextAlign.center,
                          weight: FontWeight.w500),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      homeScreenProvider.resetFilters();
                      setState(() {
                        mealFor = [];
                        mealType = -1;
                        cuisine = [];
                        cuisineName = [];
                        mealPlan = [];
                        currentRangeValues = const RangeValues(0, 1000);
                      });
                    },
                    child: poppinsText(
                      maxLines: 3,
                      txt: "RESET",
                      fontSize: 18,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FittedBox(
                child: Row(
                    children: List.generate(
                  mealTypeListWithImage.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (mealType == index) {
                            mealType = -1;
                          } else {
                            mealType = index;
                          }
                        });
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(26),
                        elevation: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  blurRadius: 8,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                )
                              ],
                              color: mealType == index
                                  ? AppConstant.appColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(26),
                              border: mealType == index
                                  ? Border.all(color: AppConstant.appColor)
                                  : Border.all(color: Colors.black54)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  mealTypeListWithImage[index].icon,
                                  width: 20,
                                  height: 20),
                              poppinsText(
                                  maxLines: 3,
                                  txt: mealTypeListWithImage[index].name,
                                  color: mealType == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                  textAlign: TextAlign.center,
                                  weight: FontWeight.w400),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 14),
              poppinsText(
                  txt: "Meal type",
                  maxLines: 3,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w500),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    mealForList.length,
                    (index) => Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (mealFor.contains(index.toString())) {
                                    mealFor.removeWhere((element) =>
                                        element == index.toString());
                                  } else {
                                    mealFor.add(index.toString());
                                  }
                                });
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(12),
                                elevation: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: mealFor.contains(index.toString())
                                        ? AppConstant.appColor
                                        : Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x26000000),
                                        blurRadius: 8,
                                        offset: Offset(0, 1),
                                        spreadRadius: 0,
                                      )
                                    ],
                                    border: mealFor.contains(index.toString())
                                        ? Border.all(
                                            color: AppConstant.appColor)
                                        : Border.all(
                                            color: HexColor('#2f3443')
                                                .withOpacity(0.5),
                                          ),
                                    borderRadius: BorderRadius.circular(
                                        12), // Border radius
                                  ),
                                  child: Center(
                                    child: poppinsText(
                                        txt: mealForList[index],
                                        color:
                                            mealFor.contains(index.toString())
                                                ? Colors.white
                                                : Colors.black,
                                        fontSize: 15,
                                        textAlign: TextAlign.center,
                                        weight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
              ),
              const SizedBox(height: 14),

              poppinsText(
                  maxLines: 3,
                  txt: "Meal Plan",
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w500),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  mealPlanList.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (mealPlan.contains(index.toString())) {
                              mealPlan.removeWhere(
                                  (element) => element == index.toString());
                            } else {
                              mealPlan.add(index.toString());
                            }
                          });
                          ;
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          elevation: 2,
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              color: mealPlan.contains(index.toString())
                                  ? AppConstant.appColor
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  blurRadius: 8,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                )
                              ],
                              border: mealPlan.contains(index.toString())
                                  ? Border.all(color: AppConstant.appColor)
                                  : Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            child: Center(
                              child: poppinsText(
                                  maxLines: 3,
                                  txt: mealPlanList[index],
                                  color: mealPlan.contains(index.toString())
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                  textAlign: TextAlign.center,
                                  weight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              poppinsText(
                maxLines: 3,
                txt: "Cuisine Types",
                fontSize: 16,
                textAlign: TextAlign.center,
                weight: FontWeight.w500,
              ),

              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.cuisineTypes.data!
                    .map((e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              if (cuisine.contains(e.package!.key!)) {
                                cuisine.removeWhere(
                                    (element) => element == e.package!.key!);
                                cuisineName.removeWhere(
                                    (element) => element == e.package!.value!);
                              } else {
                                cuisine.add(e.package!.key!);
                                cuisineName.add(e.package!.value!);
                              }
                            });
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(26),
                            elevation: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x26000000),
                                      blurRadius: 8,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                  color: cuisine.contains(e.package!.key!)
                                      ? AppConstant.appColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: cuisine.contains(e.package!.key!)
                                      ? Border.all(color: AppConstant.appColor)
                                      : Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: poppinsText(
                                  maxLines: 3,
                                  txt: e.package!.value,
                                  color: cuisine.contains(e.package!.key!)
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  textAlign: TextAlign.center,
                                  weight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 14),
              poppinsText(
                  maxLines: 3,
                  txt: "Price",
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w500),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹${currentRangeValues.start.round()}",
                  ),
                  Text(
                    "₹${currentRangeValues.end.round()}",
                  ),
                ],
              ),
              RangeSlider(
                activeColor: Colors.teal,
                values: currentRangeValues,
                min: 0,
                max: 1500,
                //divisions: 2,
                labels: RangeLabels(
                  "₹${currentRangeValues.start.round()}",
                  "₹${currentRangeValues.end.round()}",
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    currentRangeValues = values;
                    homeScreenProvider.updatePrice(
                        "${currentRangeValues.start.round()}",
                        "${currentRangeValues.end.round()}");
                  });
                },
              ),
              // poppinsText(
              //     maxLines: 3,
              //     txt: "Ratings",
              //     fontSize: 16,
              //     textAlign: TextAlign.center,
              //     weight: FontWeight.w500),
              // const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const SizedBox(width: 10),
              //     RatingBar.builder(
              //       initialRating: 0,
              //       minRating: 0,
              //       itemSize: 30.0,
              //       allowHalfRating: true,
              //       itemCount: 5,
              //       itemPadding: const EdgeInsets.only(right: 34),
              //       itemBuilder: (context, _) => const Image(
              //         image: AssetImage("assets/images/Icon_s.png"),
              //         height: 35,
              //         width: 35,
              //       ),
              //       onRatingUpdate: (newRating) {
              //         homeScreenProvider
              //             .updateRating(newRating.round().toString());
              //
              //         // value.updateRating(rating);
              //       },
              //     ),
              //   ],
              // ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  homeScreenProvider.updateMealPlan(mealPlan.join(','));
                  homeScreenProvider.updateCuisine((cuisine.join(',')));
                  homeScreenProvider.updateCuisineName(cuisineName.join(','));
                  homeScreenProvider.updateMealFor(mealFor.join(','));
                  homeScreenProvider.updateMealType(
                      (mealType == -1) ? "" : mealType.toString());

                  Logger().e(
                      "'mealfor': ${homeScreenProvider.mealFor} \n ${homeScreenProvider.mealForPackage}\n'cuisine': ${homeScreenProvider.cuisine}\n'mealPlan': ${homeScreenProvider.mealPlan}\n'mealType': ${homeScreenProvider.mealType}, \ncuisnename :${homeScreenProvider.cuisineName}");
                  Navigator.pop(
                    context,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff2F3443),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  child: Center(
                    child: poppinsText(
                        maxLines: 3,
                        txt: "APPLY FILTERS",
                        color: Colors.white,
                        fontSize: 16,
                        textAlign: TextAlign.center,
                        weight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
