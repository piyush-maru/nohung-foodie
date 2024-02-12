import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:provider/provider.dart';

import '../../../../model/menu_list_provider/menu_list_provider.dart';
import '../../../../network/kitchen_details/kitchen_details_model.dart';
import '../../../../utils/constants/app_constants.dart';

class FloatingMenu extends StatefulWidget {
  const FloatingMenu(
      {super.key, required this.kitchenID, required this.selectedIndex});
  final String kitchenID;
  final void Function(int index) selectedIndex;

  @override
  State<FloatingMenu> createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu> {
  late Future<List<OrderNowDetail>?> orderNowListFuture;
  @override
  void initState() {
    super.initState();
    orderNowListFuture = context.read<MenuListProvider>().getPreOrderDetails(
          kitchenId: widget.kitchenID,
        );
  }

  bool isMenuOpen = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuListProvider>(
      context,
    );
    if (provider.isMenuOpen) {
      return InkWell(
          onTap: () {
            setState(() {
              isMenuOpen = !isMenuOpen;
            });
            // menuListProvider.updateMenuStatus();

            showDialog(
                // barrierDismissible: true,
                context: context,
                // barrierColor: Colors.transparent,
                builder: (_) {
                  return Dialog(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FutureBuilder<List<OrderNowDetail>?>(
                          future: orderNowListFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data![index];

                                  return InkWell(
                                    onTap: () {
                                      //
                                      widget.selectedIndex(index);
                                      provider.updateSelectedMenuIndex(
                                          index: index);
                                      // Navigator.pop(context, data);
                                    },
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          color: provider.selectedMenuIndex ==
                                                  index
                                              ? kYellowColor
                                              : Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                index == 0 ? 10.0 : 0.0),
                                            topRight: Radius.circular(
                                                index == 0 ? 10.0 : 0.0),
                                          )),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0, right: 12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.categoryName,
                                                style: TextStyle(
                                                    color:
                                                        provider.selectedMenuIndex ==
                                                                index
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                data.menuItems.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                        provider.selectedMenuIndex ==
                                                                index
                                                            ? Colors.white
                                                            : Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppConstant.appColor,
                              ),
                            );
                          }),
                    ),
                  );
                }).then(
              (value) {
                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
                // menuListProvider.updateMenuStatus();
              },
            );
          },
          child: Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(0xFF2F3443),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              isMenuOpen
                  ? 'assets/icons/icon_menu_close.svg'
                  : 'assets/icons/icon_menu_open.svg',
            ),
          ));
    } else {
      return SizedBox();
    }
  }
}
