import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/cuisine_types_model/cuisine_types_model.dart';
import '../../../model/cuisine_types_provider/cuisine_types_provider.dart';
import '../../../model/home_screen_model/top_packages_model.dart';
import '../../../network/home_screen_repo/home_screen_api_controller.dart';
import '../../../utils/constants/ui_constants.dart';
import '../home_filter/home_filter_screen.dart';
import '../home_screen/widgets/top_package_details_card.dart';

class TopPackageViewAllScreen extends StatefulWidget {
  const TopPackageViewAllScreen({super.key});

  @override
  State<TopPackageViewAllScreen> createState() =>
      _TopPackageViewAllScreenState();
}

class _TopPackageViewAllScreenState extends State<TopPackageViewAllScreen> {
  Future<List<TopPackagesData>>? topPackagesFuture;
  Future<CuisineTypesModel>? getAllCuisineTypesFuture;

  @override
  void initState() {
    super.initState();
    final topPackagesData =
        Provider.of<HomeScreenProvider>(context, listen: false);
    topPackagesFuture = topPackagesData.getTopPackages(
        cuisineFilter: "", mealTypeFilter: "", mealForFilter: "");
    final cuisineTypesProvider =
        Provider.of<CuisineTypesProvider>(context, listen: false);

    getAllCuisineTypesFuture = cuisineTypesProvider.getAllCuisineTypes();
  }

  @override
  Widget build(BuildContext context) {
    final topPackagesData =
        Provider.of<HomeScreenProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        topPackagesData.resetFilters();

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFFB200),
          leadingWidth: 220,
          leading: Row(
            children: [
              InkWell(
                onTap: () {
                  topPackagesData.resetFilters();

                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/white_backButton.png',
                    width: 25,
                  ),
                ),
              ),
              poppinsText(
                  txt: "Top Packages",
                  fontSize: 20,
                  weight: FontWeight.w600,
                  color: Colors.black),
            ], // actions: [
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FutureBuilder<CuisineTypesModel>(
                  future: getAllCuisineTypesFuture,
                  builder: (context, cuisineSnapshot) {
                    if (cuisineSnapshot.hasError) {
                      debugPrint('--${cuisineSnapshot.error.toString()}');
                    }
                    if (cuisineSnapshot.hasData) {
                      return InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeFiltersScreen(
                                  cuisineTypes: cuisineSnapshot.data!),
                            ),
                          ).then((result) {
                            topPackagesFuture = topPackagesData.getTopPackages(
                              mealForFilter: topPackagesData.mealForPackage,
                              mealTypeFilter: topPackagesData.mealType,
                              cuisineFilter: topPackagesData.cuisineName,
                            );

                            setState(() {});
                          });
                        },
                        child: const Image(
                          image: AssetImage("assets/images/filters1.png"),
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
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<TopPackagesData>>(
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
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return TopPackagesDetailsCard(
                                        package: packageSnapshot.data![index],
                                      );
                                    },
                                    itemCount: packageSnapshot.data!.length,
                                  )
                            : Center(
                                child: CircularProgressIndicator(
                                    color: kYellowColor),
                              );
                      }),
                )
              ],
            )),
      ),
    );
  }
}
