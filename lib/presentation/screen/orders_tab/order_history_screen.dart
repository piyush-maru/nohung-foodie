import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/model/orders/get_active_order.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/pref_manager.dart';
import 'package:provider/provider.dart';

import '../../../network/orders_repo/active_orders_repo.dart';
import '../../../network/orders_repo/order_history_model.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../widgets/buttons/login_button.dart';
import '../authentication_screens/login/login_with_mobile_screen.dart';
import '../landing/landing_screen.dart';
import 'active_order_tab.dart';
import 'fav_order_screen.dart';
import 'order_history_tab.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  OrderHistoryScreenState createState() => OrderHistoryScreenState();
}

class OrderHistoryScreenState extends State<OrderHistoryScreen>
    with TickerProviderStateMixin {
  var isSelected = 0;
  Future<GetActiveOrders?>? future;
  TabController? _controller;
  late Future<bool> isLoggedFuture;
  List<String> tab = ['Active Orders', 'Fav Orders', 'Order History'];
  List<String> my = ["A2", "a2", "a3"];
  clearOrderList() {
    final orderHistoryModel =
        Provider.of<OrderHistoryModel>(context, listen: false);

    orderHistoryModel.clearOrderHistoryList();
  }

  @override
  initState() {
    super.initState();

    _controller = TabController(length: 3, vsync: this);
    isLoggedFuture = PrefManager.getBool(AppConstant.session);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      clearOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderHistoryModel =
        Provider.of<OrderHistoryModel>(context, listen: false);
    final screenHeight = MediaQuery.sizeOf(context).height;
    return WillPopScope(
      onWillPop: () async {
        orderHistoryModel.clearOrderHistoryList();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LandingScreen()),
            (route) => false);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // bottomNavigationBar: Bottom(selectedIndex: 1),
        appBar: AppBar(
          leadingWidth: 116,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: InkWell(
                    onTap: () {
                      orderHistoryModel.clearOrderHistoryList();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LandingScreen(),
                          ),
                          (route) => false);
                    },
                    child: Image.asset('assets/images/white_backButton.png',
                        height: 28)),
              ),
              poppinsText(
                  txt: "Orders",
                  maxLines: 3,
                  fontSize: 18,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w600),
            ],
          ),
          backgroundColor: AppConstant.appColor,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration:  const BoxDecoration(
               //boxShadow: [
               //  BoxShadow(
               //    color: Colors.grey,
               //    offset: Offset(0, 8),
               //    blurRadius: 10,
               //  ),
               //],
                color: Color.fromRGBO(246, 246, 246, 1),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: const BoxDecoration(color: Colors.white),
                indicatorColor: const Color.fromRGBO(246, 246, 246, 1.0),
                unselectedLabelColor: Colors.black,
                labelColor: Colors.black,
                isScrollable: false,
                controller: _controller,
                tabs: tab.map((item) => Tab(text: item)).toList(),
              ),
            ),
            // Container(height: 10,color: Colors.white),
            FutureBuilder<bool>(
                future: isLoggedFuture,
                builder: (BuildContext context, snapshot) {
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
                    if (snapshot.data!) {
                      return Expanded(
                        child: Container(
                          /*  margin: const EdgeInsets.only(
                            top: 16,
                          ),*/
                          decoration: const BoxDecoration(
                            color: Colors.white,

                            ///  color: Color.fromRGBO(246, 246, 246, 1.0)
                            /* borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),*/
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x26050522),
                                        blurRadius: 10,
                                        offset: Offset(4, 6),
                                        spreadRadius: 0,
                                      )
                                    ],
                                    color: Color.fromRGBO(246, 246, 246, 1.0),

                                    */ /* borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),*/ /*
                                  ),
                                  child: TabBar(
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorWeight: 2,
                                    unselectedLabelColor:
                                        Colors.black.withOpacity(0.15),
                                    labelColor: Colors.black,
                                    indicatorColor: Colors.black,
                                    isScrollable: false,
                                    controller: _controller,
                                    tabs: const [

                                      Tab(text: 'Active Orders'),
                                      Tab(text: 'Order History'),
                                      Tab(text: 'Fav Orders'),
                                    ],
                                  ),
                                ),*/
                                SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: TabBarView(
                                    controller: _controller,
                                    children: [
                                      ActiveOrdersTab(
                                        refreshOrdersCallback: () {
                                          setState(() {
                                            future = context
                                                .read<ActiveOrdersModel>()
                                                .getActiveOrders();
                                          });
                                        },
                                      ),
                                      const FavOrderScreen(),
                                      const OrderHistoryTab(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Image.asset(
                            'assets/icons/icon_order_history_not_logged_in.png',
                            // controller: _animationController,
                            height: screenHeight * 0.3,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          poppinsText(
                              txt: 'Login to check your order history.',
                              fontSize: 17,
                              textAlign: TextAlign.center,
                              weight: FontWeight.w500,
                              maxLines: 3),
                          const SizedBox(
                            height: 20,
                          ),
                          const LoginButton()
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppConstant.appColor,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<void> apiCall() async {
    bool isLogged = await PrefManager.getBool(AppConstant.session);
    if (isLogged) {
      // future = getOrderHistory();
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginWithMobileScreen()),
          ModalRoute.withName("/loginSignUp"));
    }
  }
}
