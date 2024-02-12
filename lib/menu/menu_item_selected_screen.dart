import 'package:flutter/material.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/constants/app_constants.dart';

class MenuItemSelectedScreen extends StatefulWidget {
  const MenuItemSelectedScreen({Key? key}) : super(key: key);

  @override
  _MenuItemSelectedScreenState createState() => _MenuItemSelectedScreenState();
}

class _MenuItemSelectedScreenState extends State<MenuItemSelectedScreen> {
  int isSelected = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              height: 60,
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      Res.icRightArrow,
                      width: 16,
                      height: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text(
                    "Selected Item",
                    style: TextStyle(
                        fontFamily: AppConstant.fontBold, fontSize: 20),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Selected any of the below to make it as a default dis\n for the day.",
                style: TextStyle(
                    fontFamily: AppConstant.fontRegular,
                    fontSize: 13,
                    color: Colors.grey),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return getItem(choices[index], index);
              },
              itemCount: choices.length,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "+ ADD MEAL",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 10),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getItem(Choice choice, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text(choice.title.toString(),
              style: const TextStyle(
                  color: Colors.black, fontFamily: AppConstant.fontBold)),
        ),
        const SizedBox(
          height: 16,
        ),
        GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 3 / 2,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: List.generate(subItem.length, (index) {
            return getListFood(subItem[index], index);
          }),
        ),
      ],
    );
  }

  getListFood(SubItem subItem, int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isSelected = index;
            });
          },
          child: Container(
            height: 40,
            width: 160,
            decoration: BoxDecoration(
                color: isSelected == index
                    ? const Color(0xff7EDABF)
                    : const Color(0xffF3F6FA),
                borderRadius: BorderRadius.circular(100)),
            margin:
                const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  subItem.title!,
                  style: TextStyle(
                      color: isSelected == index ? Colors.white : Colors.black,
                      fontSize: 12,
                      fontFamily: AppConstant.fontRegular),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Choice {
  Choice({this.title, this.image});

  String? title;
  String? image;
}

List<Choice> choices = <Choice>[
  Choice(title: 'Veg'),
  Choice(title: 'Dal'),
  Choice(title: 'Bread'),
  Choice(title: 'Rice'),
  Choice(title: 'other'),
];

class SubItem {
  SubItem({this.title});

  String? title;
}

List<SubItem> subItem = <SubItem>[
  SubItem(title: 'Muttor Paneer'),
  SubItem(title: 'Bhindi'),
  SubItem(title: 'Mix Veg'),
  SubItem(title: 'Plain Dal'),
  SubItem(title: 'dal Fry'),
];
