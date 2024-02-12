import 'package:flutter/material.dart';
import 'package:food_app/network/home_screen_repo/home_screen_search.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../model/searchData/home_screen_search_model.dart';
import '../../../utils/constants/ui_constants.dart';
import '../kitchen_details/kitchen_details_screen.dart';
import '../landing/landing_screen.dart';

class SearchData extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    query;
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LandingScreen(),
            ),
            (route) => false);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchModel = Provider.of<SearchHomeScreenModel>(context, listen: false);
    // TODO: implement buildResults
    return Scaffold(
      body: FutureBuilder<HomeScreenSearch>(
          future: searchModel.getSearchData(query),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.done && snapshot.data != null
                ? ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => KitchenDetailsScreen(
                                  snapshot.data!.data[index].kitchenId,
                                  OrderCategory.Subscription.toJsonKey()),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12, top: 12),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                              color: Colors.white),
                          child: Row(children: [
                            Image.network(
                              snapshot.data!.data[index].image,
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.data[index].name,
                                  style: const TextStyle(
                                      fontFamily: AppConstant.fontBold),
                                ),
                                Text(
                                  snapshot.data!.data[index].description,
                                  style: const TextStyle(
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      );
                    })
                : const SizedBox(
                    height: 250,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppConstant.appColor,
                      ),
                    ),
                  );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final searchModel =
        Provider.of<SearchHomeScreenModel>(context, listen: false);
    // TODO: implement buildResults
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LandingScreen(),
            ),
            (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                    child: Image.asset("assets/images/white_back.png",
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
        ),
        body: FutureBuilder<HomeScreenSearch>(
            future: searchModel.getSearchData(query),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => KitchenDetailsScreen(
                                    snapshot.data!.data[index].kitchenId,
                                    OrderCategory.Subscription.toJsonKey()),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12, top: 12),
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(
                                      2.0,
                                      2.0,
                                    ),
                                    blurRadius: 5.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                                color: Colors.white),
                            child: Row(children: [
                              Image.network(
                                snapshot.data!.data[index].image,
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 250),
                                      child: Text(
                                        snapshot.data!.data[index].name,
                                        style: const TextStyle(
                                            fontFamily: AppConstant.fontBold),
                                      )),
                                  Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 250),
                                      child: Text(
                                        snapshot.data!.data[index].description,
                                        style: const TextStyle(
                                            fontFamily:
                                                AppConstant.fontRegular),
                                      )),
                                ],
                              ),
                            ]),
                          ),
                        );
                      })
                  : const SizedBox(
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppConstant.appColor,
                        ),
                      ),
                    );
            }),
      ),
    );
  }
}
