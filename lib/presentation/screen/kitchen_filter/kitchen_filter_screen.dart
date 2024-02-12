import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/home_screen_model/home_screen_model.dart';
import '../../../model/kitchen_filter_model/kitchen_filter_model.dart';
import '../../../network/home_screen_repo/home_screen_api_controller.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/ui_constants.dart';
import '../home_screen/widgets/kitchen_details_home_screen_card.dart';

class FilteredKitchensScreen extends StatelessWidget {
  const FilteredKitchensScreen({required this.kitchenFilters, super.key});
  final KitchenFilters kitchenFilters;
  @override
  Widget build(BuildContext context) {
    final homeKitchenData =
        Provider.of<HomeScreenProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFB200),
        elevation: 0,
        leadingWidth: 116,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset('assets/images/white_backButton.png',
                      height: 28)),
            ),
            poppinsText(
                txt: "Search",
                maxLines: 3,
                fontSize: 18,
                textAlign: TextAlign.center,
                weight: FontWeight.w600),
          ],
        ),
        actions: [
          InkResponse(
            onTap: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const FilterScreen(),
              //   ),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: const Image(
                image: AssetImage("assets/images/filters1.png"),
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder<HomeKitchen>(
                future:
                    homeKitchenData.filteredKitchens(filters: kitchenFilters),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppConstant.appColor,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    if (snapshot.data!.data.isEmpty) {
                      return Center(
                        child: poppinsText(
                            txt: 'No Kitchen Found',
                            fontSize: 22,
                            weight: FontWeight.w500),
                      );
                    } else {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.data.length,
                          itemBuilder: (context, index) {
                            return KitchenDetailsHomeScreenCard(
                              snapshot: snapshot.data!.data![index],
                            );
                          });
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppConstant.appColor,
                    ),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
