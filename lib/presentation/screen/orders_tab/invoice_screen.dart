import 'package:flutter/material.dart';
import 'package:food_app/model/orders/invoice_model.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/helper_class.dart';
import 'package:provider/provider.dart';

import '../../../network/orders_repo/invoice_model.dart';
import '../../../res.dart';

class InvoiceScreen extends StatefulWidget {
  final String orderId;

  const InvoiceScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    final invoiceModel = Provider.of<InvoiceModel>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: /*Consumer<InvoiceModel>(builder: (context, invoiceModel, child) {
          return*/
            FutureBuilder<InvoiceModelClass?>(
                future: invoiceModel.getInvoice(widget.orderId),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.done &&
                          snapshot.data != null
                      ? ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      Res.logo,
                                      height: 100,
                                      width: 100,
                                    )),
                                const Text(
                                  "Invoice",
                                  style: TextStyle(
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text(
                                  "Original Receipt",
                                  style: TextStyle(
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black),
                                            top:
                                                BorderSide(color: Colors.black),
                                            left:
                                                BorderSide(color: Colors.black),
                                            right:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: const Text(
                                                  "Order ID : ",
                                                  style: TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "${snapshot.data!.data![index]!.orderNumber}",
                                                  style: const TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: const Text(
                                                  "Order Time : ",
                                                  style: TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  Helper.formatInvoiceDateString(
                                                      "${snapshot.data!.data![index]!.orderTime}"),
                                                  style: const TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          if (snapshot
                                                  .data!
                                                  .data[index]
                                                  .subscriptionPeriod
                                                  .isNotEmpty &&
                                              snapshot.data?.data[index]
                                                      .subscriptionPeriod !=
                                                  null)
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: const Text(
                                                    "Subscription Period : ",
                                                    style: TextStyle(
                                                        fontFamily: AppConstant
                                                            .fontRegular),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    "${snapshot.data!.data![index]!.subscriptionPeriod}",
                                                    style: const TextStyle(
                                                        fontFamily: AppConstant
                                                            .fontRegular),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: const Text(
                                                  "Customer Name : ",
                                                  style: TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "${snapshot.data!.data![index]!.customerName}",
                                                  style: const TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: const Text(
                                                  "Delivery Address : ",
                                                  style: TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "${snapshot.data!.data![index]!.deliveryAddress}",
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.visible,
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: const Text(
                                                  "Kitchen Name : ",
                                                  style: TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "${snapshot.data!.data![index]!.kitchenName}",
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.fade,
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: const Text(
                                                  "Payment Mode :",
                                                  style: TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "${snapshot.data!.data![index]!.paymentMode}",
                                                  style: const TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                            ],
                                          )
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(12),
                                        color: const Color(0xFF2f3443)
                                            .withOpacity(0.4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Item",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Quantity",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Unit Price",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Sub Total",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Delivery Charges ${Helper.extractDaysSubstringInInvoice(snapshot.data!.data[index].subscriptionPeriod)}",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Packaging Charges ${Helper.extractDaysSubstringInInvoice(snapshot.data!.data[index].subscriptionPeriod)}",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Coupon",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Taxes",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Total",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.all(12),
                                          color: const Color(0xFF2f3443)
                                              .withOpacity(0.2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${snapshot.data!.data![index]!.itemName}",
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                snapshot.data!.data![index]!
                                                    .itemQuantity
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "${AppConstant.rupee} ${snapshot.data!.data![index]!.unitPrice}",
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "${AppConstant.rupee} ${snapshot.data!.data![index]!.subTotal}",
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "${AppConstant.rupee} ${snapshot.data!.data![index]!.deliveryCharge}",
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "${AppConstant.rupee} ${snapshot.data!.data![index]!.packagingCharges}",
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "${AppConstant.rupee} ${snapshot.data!.data![index]!.couponDiscount}",
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "${AppConstant.rupee} ${snapshot.data!.data![index]!.taxAmount}",
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "${AppConstant.rupee} ${snapshot.data!.data![index]!.total}",
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              )
                                            ],
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            );
                          })
                      : const Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Loading",
                                style: TextStyle(
                                    fontFamily: AppConstant.fontRegular),
                              ),
                              CircularProgressIndicator(
                                color: AppConstant.appColor,
                              )
                            ],
                          ));
                }));
  }
}
