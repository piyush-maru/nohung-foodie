import 'package:flutter/material.dart';
import 'package:food_app/model/orders/get_order_history.dart';
import 'package:food_app/presentation/screen/orders_tab/widget/order_history_card.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../network/orders_repo/order_history_model.dart';
import '../../../utils/constants/ui_constants.dart';
import '../landing/landing_screen.dart';

class OrderHistoryTab extends StatefulWidget {
  const OrderHistoryTab({Key? key}) : super(key: key);

  @override
  State<OrderHistoryTab> createState() => _OrderHistoryTabState();
}

class _OrderHistoryTabState extends State<OrderHistoryTab> {
  late ScrollController controller;

  bool like = false;
  bool disLike = true;
  Future<List<Order>?>? future;
  int offset = 0;

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 50) {
      final orderHistoryModel =
          Provider.of<OrderHistoryModel>(context, listen: false);
      orderHistoryModel.updatedLoading(true);
      offset = offset + 10;

      orderHistoryModel.orderHistory(offset: offset.toString());
    }
  }

  loadData() {
    final orderHistoryModel =
        Provider.of<OrderHistoryModel>(context, listen: false);

    orderHistoryModel.orderHistory(offset: offset.toString());
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      loadData();
    });
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Consumer<OrderHistoryModel>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            provider.clearOrderHistoryList();
            return true;
          },
          child: Scaffold(
              body: (provider.orderHistoryList.isEmpty)
                  ? SizedBox(
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          Image.asset(
                            'assets/images/image_no_orders.png',
                            width: screenWidth * 0.7,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          poppinsText(
                              txt: 'NO ORDER YET',
                              fontSize: 22,
                              weight: FontWeight.w500),
                          const SizedBox(
                            height: 20,
                          ),
                          InkResponse(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LandingScreen(),
                                  ),
                                  (route) => false);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: ShapeDecoration(
                                color: kYellowColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Text(
                                "Browse Kitchens",
                                style: AppTextStyles.titleText.copyWith(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      color: AppConstant.appColor,
                      onRefresh: () async {
                        await Future.delayed(Duration(seconds: 1));
                        setState(() {});
                      },
                      child: ListView(
                        controller: controller,
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: provider.orderHistoryList.length + 1,
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 20),
                              itemBuilder: (context, int index) {
                                if (index == provider.orderHistoryList.length) {
                                  return SizedBox(
                                      height: 300,
                                      child: provider.isLoading
                                          ? const Align(
                                              alignment: Alignment.topCenter,
                                              child: CircularProgressIndicator(
                                                color: AppConstant.appColor,
                                              ))
                                          : SizedBox());
                                } else {
                                  return OrderHistoryCard(
                                    data: provider.orderHistoryList[index],
                                  );
                                }
                              }),
                        ],
                      ),
                    )),
        );
      },
    );
  }
}
