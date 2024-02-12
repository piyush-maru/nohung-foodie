import 'package:flutter/material.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/constants/app_constants.dart';

class AddPackageScreen extends StatefulWidget {
  const AddPackageScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddPackageScreenState();
}

class AddPackageScreenState extends State<AddPackageScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Image.asset(
                Res.back,
                width: 16,
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Package 1",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Lunch",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Image.asset(
                Res.veg,
                width: 16,
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Veg",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "North indian meals",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppConstant.fontBold,
                      fontSize: 16),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return addPackage();
            },
            itemCount: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(13)
            ),
            width: double.infinity,
            height: 70,
            margin: const EdgeInsets.only(left: 16,right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16,left: 16),
                  child: Text("₹300",style: TextStyle(color: Color(0xff7EDABF)),),
                ),
                Row(
                  children: [
                     const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 6,left: 16),
                        child: Text("Order for a week",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 6,left: 16,bottom: 10),
                      child: Text("Add to basket",style: TextStyle(color: Colors.white),),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(

                      padding: const EdgeInsets.only(right: 16),
                        child: Image.asset(Res.nextArrow,width: 16,height: 16,)),

                  ],
                )

              ],
            ),
          ),
        ],
      )),
    ));
  }

  Widget addPackage() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 6, top: 10),
                    child: Text(
                      "Monday",
                      style: TextStyle(
                          color: AppConstant.appColor,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 16),
                    )),
              ),
              InkWell(
                onTap: () {
                  bottomsheet(context);
                },
                child: const Text(
                  "Customizable",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 6),
            child: Text(
              "Mutter Paneer+3 Roti\n+Dal Fry+Rice",
              style: TextStyle(
                  color: Color(0xffA7A8BC),
                  fontSize: 13,
                  fontFamily: AppConstant.fontRegular),
            ),
          ),
        ],
      ),
    );
  }

  void bottomsheet(BuildContext context) {
    showModalBottomSheet(
        shape:  const RoundedRectangleBorder(
          // <-- for border radius
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModelState) {
            return Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Select for below option",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: AppConstant.fontBold,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Image.asset(
                              Res.icCross,
                              width: 16,
                              height: 16,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return getTitle(item[index]);
                      },
                      itemCount: item.length,
                    ),
                  ],
                )
              ],
            );
          });
        });
  }

  getTitle(ITEM item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text(
            item.title!,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: AppConstant.fontBold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return getSubCategory(food[index], index);
          },
          itemCount: food.length,
        ),
      ],
    );
  }

  getSubCategory(FOOD food, int index) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white, // color of tick Mark
              activeColor: AppConstant.lightGreen, // c
              onChanged: (value) {

                setState(() {
                  food.isCheckbox = value;
                });
              },
              value: food.isCheckbox ?? false,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(food.title!),
            )),
            addItem(food, index)
          ],
        )
      ],
    );
  }

  addItem(FOOD food, int index) {
    if (index == 1) {
      return Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 6),
          height: 25,
          width: 50,
          decoration: BoxDecoration(
              color: AppConstant.appColor,
              borderRadius: BorderRadius.circular(100)),
          child: const Row(
            children: [

              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                  "-",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "2",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "+",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16),
          child: Text(
            "₹25 extra",
            style: TextStyle(fontFamily: AppConstant.fontRegular, fontSize: 14),
          ),
        )
      ]);
    } else {
      return const Padding(
        padding: EdgeInsets.only(right: 16),
        child: Text(
          "₹25 extra",
          style: TextStyle(fontFamily: AppConstant.fontRegular, fontSize: 14),
        ),
      );
    }
  }
}

class ITEM {
  ITEM({this.title});

  String? title;
}

List<ITEM> item = <ITEM>[
  ITEM(title: 'Vegetables'),
  ITEM(title: 'Bread'),
];

class FOOD {
  FOOD({this.title, this.isCheckbox});

  String? title;
  bool? isCheckbox;
}

List<FOOD> food = <FOOD>[
  FOOD(title: 'Mutter Paneer', isCheckbox: false),
  FOOD(title: 'Bhindi', isCheckbox: false),
];
