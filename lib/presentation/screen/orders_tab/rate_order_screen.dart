import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:provider/provider.dart';

import '../../../network/orders_repo/rate_order_model.dart';

class RateOrderScreen extends StatefulWidget {
  final String kitchenId;
  final String orderId;

  const RateOrderScreen({Key? key, required this.kitchenId, required this.orderId})
      : super(key: key);

  @override
  State<RateOrderScreen> createState() => _RateOrderScreenState();
}

class _RateOrderScreenState extends State<RateOrderScreen> {
  String _foodQuantity = "";
  String _taste = "";
  String _quantity = "";
  final reviewMessage = TextEditingController();
  double ratingValues = 0.0;


  @override
  Widget build(BuildContext context) {
    final rateOrderModel = Provider.of<RateOrderModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 35,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset("assets/images/backyellowbutton.png",
                  height: 28)),
        ),

     title:    poppinsText(
         txt: "Rate your Food Experience",
         maxLines: 3,
         fontSize: 18,
         textAlign: TextAlign.center,
         weight: FontWeight.w600),
      ),
      body:Consumer<RateOrderModel>(builder: (context, value, child) {
        return SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset("assets/images/rating_2.png",
                    height: 150, width: 220),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                    Container(
                     // color: Colors.red,
                      width: double.infinity,//330,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 8,
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                            ),
                            child: Container(
                              height: 48,
                              width: 48,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Card(
                            elevation: 8,
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                            ),
                            child: Container(
                              height: 48,
                              width: 48,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Card(
                            elevation: 8,
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                            ),
                            child: Container(
                              height: 48,
                              width: 48,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Card(
                            elevation: 8,
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                            ),
                            child: Container(
                              height: 48,
                              width: 48,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Card(
                            elevation: 8,
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  10),
                            ),
                            child: Container(
                              height: 48,
                              width: 48,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,//310,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 9.0,left: 13),
                        child: RatingBar.builder(
                          initialRating: 5,
                          minRating: 1,
                          itemSize: 30.0,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.only(right: 30),
                          itemBuilder: (context, _) => const Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Image(
                              image: AssetImage("assets/images/Icon_s.png"),
                              height: 90,
                              width: 90,
                            ),
                          ),
                          onRatingUpdate: (rating) {
                            value.updateRating(rating);
                          },
                        ),
                      ),
                    ),
                  ],),
                ),
              ),
            /*  Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Container(
                  height: 70,
                  width: 310,
                  //color: Colors.red,
                  child: FittedBox(
                    child: RatingBar.builder(
                      initialRating: 5,
                      minRating: 1,
                      itemSize: 70.0,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.only(right: 34),
                      itemBuilder: (context, _) => *//*Card(
                              elevation: 8,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    12),
                              ),
                              child:Container(
                                height: 150,
                                width: 150,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Image(
                                    image: AssetImage("assets/images/Icon_s.png"),
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                              ),
                            ),*//*const Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Image(
                          image: AssetImage("assets/images/Icon_s.png"),
                          height: 100,
                          width: 100,
                        ),
                      ),
                      *//*Icon(
                                Icons.star,
                                color: AppConstant.appColor,
                              ),*//*
                      onRatingUpdate: (rating) {
                        value.updateRating(rating);
                      },
                    ),
                  ),
                ),
              ),*/
              const SizedBox( height: 10),
              poppinsText(
                  txt: "Write a review",
                  maxLines: 3,
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w500),
          const SizedBox(
            height: 8,
          ),
          const TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintStyle:
                  TextStyle(fontFamily: AppConstant.fontRegular, fontSize: 10),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
         /* RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              ratingValues = rating;
            },
          ),*/
              Center(
                child: Container(
                  width: 280,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          poppinsText(
                              txt: "Food quality",
                              maxLines: 3,
                              fontSize: 16,
                              textAlign: TextAlign.center,
                              weight: FontWeight.w500),
                          Row(children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _foodQuantity = "1";
                                });
                              },
                              icon: Icon(
                                Icons.thumb_up,
                                color: _foodQuantity == "1"
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _foodQuantity = "2";
                                });
                              },
                              icon: Icon(
                                Icons.thumb_down,
                                color: _foodQuantity == "2" ? const Color(0xffEACBC6) : Colors.black,
                              ),
                            )
                          ],),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          poppinsText(
                              txt: "Taste",
                              maxLines: 3,
                              fontSize: 16,
                              textAlign: TextAlign.center,
                              weight: FontWeight.w500),
                          Row(children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _taste = '1';
                                });
                              },
                              icon: Icon(
                                Icons.thumb_up,
                                color: _taste == '1' ? Colors.blue : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _taste = '2';
                                });
                              },
                              icon: Icon(
                                Icons.thumb_down,
                                color: _taste == "2" ? const Color(0xffEACBC6) : Colors.black,
                              ),
                            )
                          ],),


                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          poppinsText(
                              txt: "Quantity",
                              maxLines: 3,
                              fontSize: 16,
                              textAlign: TextAlign.center,
                              weight: FontWeight.w500),

                          Row(children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _quantity = "1";
                                });
                              },
                              icon: Icon(
                                Icons.thumb_up,
                                color: _quantity == "1" ? Colors.blue : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _quantity = "2";
                                });
                              },
                              icon: Icon(
                                Icons.thumb_down,
                                color: _quantity == "2" ? const Color(0xffEACBC6) : Colors.black,
                              ),
                            )
                          ],),

                        ],
                      ),
                    ],
                  ),
                ),
              ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: ElevatedButton(

                onPressed: () {
                  if (ratingValues == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please rate the order"),
                      ),
                    );
                  } else if (_foodQuantity.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please rate food quantity of the order"),
                      ),
                    );
                  } else {
                    rateOrderModel.rateOrder(
                        context,
                        widget.kitchenId,
                        widget.orderId,
                        ratingValues.toDouble(),
                        _foodQuantity,
                        reviewMessage.text,
                        _taste,
                        _quantity);
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kTextPrimary),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                  child: poppinsText(
                      txt: "Submit",
                      color: Colors.white,
                      maxLines: 3,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ]),
      );}),
    );
  }
}
