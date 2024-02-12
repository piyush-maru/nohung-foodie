import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../../model/orders/get_order_history.dart';
import '../../../../network/orders_repo/active_orders_repo.dart';
import '../../../../res.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helper_class.dart';
import '../../kitchen_details/kitchen_details_screen.dart';
import '../invoice_screen.dart';
import '../order_history_preview.dart';
import '../rate_order_screen.dart';

class OrderHistoryCard extends StatefulWidget {
  const OrderHistoryCard({super.key, required this.data});
  final Order data;

  @override
  State<OrderHistoryCard> createState() => _OrderHistoryCardState();
}

class _OrderHistoryCardState extends State<OrderHistoryCard> {
  @override
  Widget build(BuildContext context) {
    final activeModel = Provider.of<ActiveOrdersModel>(context, listen: false);

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(
              2.0,
              2.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ], borderRadius: BorderRadius.circular(12), color: Colors.white),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${widget.data.kitchenname}',
                      style: const TextStyle(
                          fontFamily: AppConstant.fontBold, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    /*Text(
                    (widget.data.isComplete == '1')
                        ? "Completed"//Subscription
                        : (widget.data.status == '2')
                        ? ""
                        : "Active",
                    style: TextStyle(
                        color: (widget.data.isComplete == '1')
                            ? Colors.green
                            : Colors.green,
                        fontSize: 16,
                        fontFamily: AppConstant.fontRegular),
                  ),*/
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /* if (*/ widget.data.ordertype == "package" &&
                                    int.parse(widget.data.status ?? "") == 1 ||
                                int.parse(widget.data.status ?? "") == 3 ||
                                int.parse(widget.data.status ?? "") == 0 ||
                                int.parse(widget.data.status ?? "") == 4 ||
                                int.parse(widget.data.status ?? "") == 5
                            ? Column(
                                children: [
                                  Row(children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            opaque: false,
                                            pageBuilder:
                                                (BuildContext context, _, __) =>
                                                    OrderHistoryPreview(
                                              orderItemId: widget.data.orderId
                                                  .toString(),
                                              orderId: widget.data.orderId
                                                  .toString(),
                                              kitchenName: widget
                                                  .data.kitchenname
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: widget.data.isComplete == "1"
                                          ? const Text(
                                              "Preview  ",
                                              style: TextStyle(
                                                color: AppConstant.appColor,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                              ),
                                            )
                                          : widget.data.ordertype == "package"
                                              ? const Text(
                                                  "Customize  ",
                                                  style: TextStyle(
                                                      color:
                                                          AppConstant.appColor,
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                )
                                              : SizedBox(),
                                    ),
                                    widget.data.isComplete == "1"
                                        ? const Icon(
                                            size: 18,
                                            Icons.remove_red_eye,
                                            color: AppConstant.appColor,
                                          )
                                        : widget.data.ordertype == "package"
                                            ? SvgPicture.asset(
                                                "assets/images/customize.svg",
                                                color: AppConstant.appColor,
                                                height: 15,
                                                width: 15,
                                              )
                                            : SizedBox()
                                  ]),
                                  widget.data.ordertype == "package" &&
                                              int.parse(widget.data.status ??
                                                      "") ==
                                                  2 &&
                                              widget.data.isComplete == "1" ||
                                          widget.data.ordertype == "package"
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: SizedBox(
                                              width:
                                                  widget.data.isComplete == "1"
                                                      ? 75
                                                      : 84,
                                              child: const Divider(
                                                color: AppConstant.appColor,
                                                height: 2,
                                                thickness: 1,
                                              )),
                                        )
                                      : const SizedBox()
                                ],
                              )
                            : int.parse(widget.data.status.toString()) == 2 &&
                                    widget.data.ordertype == "package"
                                ?
                                // if (int.parse(widget.data.status.toString()) == 2 && widget.data.ordertype == "package")
                                Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder:
                                                    (BuildContext context, _,
                                                        __) {
                                                  return OrderHistoryPreview(
                                                      orderItemId: "",
                                                      orderId:
                                                          widget.data.orderId ??
                                                              "");
                                                }),
                                          );
                                        },
                                        child: const Row(children: [
                                          Text(
                                            "Preview  ",
                                            style: TextStyle(
                                              color: AppConstant.appColor,
                                              fontFamily:
                                                  AppConstant.fontRegular,
                                            ),
                                          ),
                                          Icon(
                                            Icons.remove_red_eye,
                                            color: AppConstant.appColor,
                                          )
                                        ]),
                                      ),
                                      int.parse(widget.data.status
                                                      .toString()) ==
                                                  2 &&
                                              widget.data.ordertype == "package"
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 1.0),
                                              child: SizedBox(
                                                  width: 80,
                                                  child: Divider(
                                                    color: AppConstant.appColor,
                                                    height: 2,
                                                    thickness: 1,
                                                  )),
                                            )
                                          : const SizedBox(),
                                    ],
                                  )
                                : const SizedBox(),
                        /*Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: SizedBox(
                            width:int.parse(widget.data.status.toString()) == 2 && widget.data.ordertype == "package"?80:84,
                            child: const Divider(color: AppConstant.appColor, height: 2,thickness: 1,)),
                      )*/
                      ],
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    InkWell(
                        onTap: () async {
                          widget.data.favoriteOrder == "0"
                              ? activeModel
                                  .addToFav(widget.data.orderId.toString())
                                  .then((response) {
                                  if (response.statusCode == 200) {
                                    setState(() {
                                      widget.data.favoriteOrder = "1";
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                          "Added to Fav",
                                          style: TextStyle(
                                              fontFamily:
                                                  AppConstant.fontRegular),
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                          "Something went wrong",
                                          style: TextStyle(
                                              fontFamily:
                                                  AppConstant.fontRegular),
                                        ),
                                      ),
                                    );
                                  }
                                })
                              : activeModel
                                  .removeFromFav(widget.data.orderId.toString())
                                  .then((response) {
                                  if (response.statusCode == 200) {
                                    setState(() {
                                      widget.data.favoriteOrder = "0";
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                          "Removed from fav order",
                                          style: TextStyle(
                                              fontFamily:
                                                  AppConstant.fontRegular),
                                        ),
                                      ),
                                    );
                                  }
                                });
                        },
                        child: SvgPicture.asset(
                          widget.data.favoriteOrder == "1"
                              ? Res.heartFill
                              : Res.heartOutline,
                          color: widget.data.favoriteOrder == "1"
                              ? Colors.red
                              : Colors.red,
                          height: 20,
                          width: 20,
                        )),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${AppConstant.rupee}${widget.data.netamount}", //Price  :
                      style: const TextStyle(
                          fontFamily: AppConstant.fontRegular,
                          color: Colors.black),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  if (widget.data.ordertype == "package")
                    Text(
                      (widget.data.isComplete == '1')
                          ? "Subscription Completed" //Subscription
                          : (widget.data.status == '2')
                              ? ""
                              : "Subscription Active",
                      style: TextStyle(
                          color: (widget.data.isComplete == '1')
                              ? Colors.green
                              : Colors.green,
                          fontSize: 16,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  if (widget.data.ordertype == "trial")
                    Text(
                      (widget.data.isComplete == '1')
                          ? "Completed" //Subscription
                          : (widget.data.status == '2')
                              ? ""
                              : "Active",
                      style: TextStyle(
                          color: (widget.data.isComplete == '1')
                              ? Colors.green
                              : Colors.green,
                          fontSize: 16,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  widget.data.ordertype == "package" &&
                              widget.data.status == "2" ||
                          widget.data.ordertype == "trial" &&
                              widget.data.status == "2" ||
                          widget.data.ordertype == "package" &&
                              widget.data.status == "7" ||
                          widget.data.ordertype == "trial" &&
                              widget.data.status == "2" ||
                          widget.data.ordertype == "package" &&
                              widget.data.status == "8"
                      ? Text(
                          Helper.getOrderHistoryStatus(
                            status: widget.data.status ?? "",
                            orderType: widget.data.ordertype ?? "",
                          ),
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontFamily: AppConstant.fontRegular),
                        )
                      : SizedBox(),
                ]),
                /* const SizedBox(
                  width: 6,
                ),
                if (widget.data.ordertype == "package" &&
                        int.parse(widget.data.status ?? "") == 1 ||
                    int.parse(widget.data.status ?? "") == 3 ||
                    int.parse(widget.data.status ?? "") == 0 ||
                    int.parse(widget.data.status ?? "") == 4 ||
                    int.parse(widget.data.status ?? "") == 5)
                  Row(children: [
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                OrderHistoryPreview(
                              orderItemId: widget.data.orderId.toString(),
                              orderId: widget.data.orderId.toString(),
                            ),
                          ),
                        );
                      },
                      child: widget.data.isComplete == "1"?const Text(
                                "Preview  ",
                                style: TextStyle(
                                 color: AppConstant.appColor,
                                     fontFamily: AppConstant.fontRegular,
                                   ),
                                   ):const Text(
                        "Customize  ",
                        style: TextStyle(
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                    widget.data.isComplete == "0"
                        ? SvgPicture.asset(
                            "assets/images/customize.svg",
                            color: AppConstant.appColor,
                            height: 15,
                            width: 15,
                          )
                        : const Icon(
                            Icons.remove_red_eye,
                            color: AppConstant.appColor,
                          )
                  ]),

                if (int.parse(widget.data.status.toString()) == 2 && widget.data.ordertype == "package")
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return OrderHistoryPreview(
                                  orderItemId: "",
                                  orderId: widget.data.orderId ?? "");
                            }),
                      );
                    },
                    child: const Row(children: [
                      Text(
                        "Preview  ",
                        style: TextStyle(
                          color: AppConstant.appColor,
                          fontFamily: AppConstant.fontRegular,
                        ),
                      ),
                      Icon(
                        Icons.remove_red_eye,
                        color: AppConstant.appColor,
                      )
                    ]),
                  ),*/
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            widget.data!.cuisineType != ""
                ? Container(
                    //width: 170,
                    //color: Colors.red,
                    child: Text(
                      widget.data!.cuisineType.toString(),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  )
                : const SizedBox(),
            /* Text(
              "${AppConstant.rupee}${widget.data.netamount}",//Price  :
              style: const TextStyle(
                  fontFamily: AppConstant.fontRegular, color: Colors.black),
            ),*/
            const SizedBox(
              height: 6,
            ),
            widget.data.ordertype == "package"
                ? Row(
                    children: [
                      const Text(
                        "Package Name  :",
                        style: TextStyle(
                          fontFamily: AppConstant.fontRegular,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '${widget.data.packageDetail?[0].itemName}',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: AppConstant.fontRegular),
                      )
                    ],
                  )
                : Container(),
            widget.data.ordertype.toString() == "trial"
                ? Row(
                    children: [
                      const Text(
                        "Item   :",
                        style: TextStyle(
                          fontFamily: AppConstant.fontRegular,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          '${widget.data.trialOrders?[0].itemName}',
                          style: const TextStyle(
                              color: Colors.black54,
                              fontFamily: AppConstant.fontRegular),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Text(
                  "Order No :",
                  style: TextStyle(
                    fontFamily: AppConstant.fontRegular,
                    color: Colors.black,
                  ),
                ),
                Text(
                  " ${widget.data.ordernumber}",
                  style: const TextStyle(
                      color: Colors.black54,
                      fontFamily: AppConstant.fontRegular),
                )
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            if (widget.data.ordertype != "package")
              Row(
                children: [
                  const Text(
                    "Delivery On : ",
                    style: TextStyle(
                      fontFamily: AppConstant.fontRegular,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.data.orderNowDeliveryDate['date'] +
                        ', ' +
                        widget.data.orderNowDeliveryDate['from_time'],
                    style: const TextStyle(
                        color: Colors.black54,
                        fontFamily: AppConstant.fontRegular),
                  )
                ],
              ),
            if (widget.data.ordertype != "package")
              const SizedBox(
                height: 6,
              ),
            widget.data.ordertype == "package"
                ? Row(
                    children: [
                      const Text(
                        "Order From :",
                        style: TextStyle(
                          fontFamily: AppConstant.fontRegular,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        " ${widget.data.orderfrom} ",
                        style: const TextStyle(
                            color: Colors.black54,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Text(
                  "Ordered On :",
                  style: TextStyle(
                    fontFamily: AppConstant.fontRegular,
                    color: Colors.black,
                  ),
                ),
                Text(
                  " ${dateTimeFormat(widget.data.createddate.toString(), "dd MMM yyyy hh:mm a")} ",
                  style: const TextStyle(
                      color: Colors.black54,
                      fontFamily: AppConstant.fontRegular),
                )
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    print(widget.data.orderId);
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) {
                            return InvoiceScreen(
                              orderId: widget.data.orderId.toString(),
                            );
                          }),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "View Invoice  ",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppConstant.fontRegular,
                            color: Colors.black),
                      ),
                      SvgPicture.asset(
                        "assets/images/invoice.svg",
                        height: 16,
                        width: 16,
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) {
                            return KitchenDetailsScreen(
                                initialIndex:
                                    widget.data.ordertype == 'trial' ? 1 : 0,
                                widget.data.kitchenId ?? "",
                                widget.data.ordertype == 'trial'
                                    ? OrderCategory.OrderNow.toJsonKey()
                                    : OrderCategory.Subscription.toJsonKey());
                          }),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppConstant.appColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all(
                      const Size(100, 20),
                    ),
                  ),
                  child: const Text(
                    "Repeat Order",
                    style: TextStyle(
                        fontFamily: AppConstant.fontRegular,
                        fontSize: 11,
                        color: Colors.black),
                  ),
                ),
                if (widget.data.isReview == 0 && widget.data.status == "6")
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              RateOrderScreen(
                            kitchenId: widget.data.kitchenId ?? "",
                            orderId: widget.data.orderId ?? "",
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        const Size(85, 30),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(150, 153, 160, 1.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Rate Order",
                      style: TextStyle(
                          fontFamily: AppConstant.fontRegular,
                          fontSize: 11,
                          color: Colors.white),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
