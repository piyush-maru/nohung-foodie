import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/network/kitchen_details/kitchen_details_model.dart';
import 'package:food_app/utils/constants/ui_constants.dart';

class PreorderCard extends StatefulWidget {
  final MenuItem? menuItem;
  final KitchenDetailsData? kitchenDetails;
  final void Function() onAddTap;

  const PreorderCard({
    super.key,
    required this.menuItem,
    required this.onAddTap,
    this.kitchenDetails,
  });

  @override
  State<PreorderCard> createState() => _PreorderCardState();
}

class _PreorderCardState extends State<PreorderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // You can adjust the elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 7, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: FittedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/leaf.svg',
                      width: 20, height: 20),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 150,
                    //color: Colors.yellow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        poppinsText(
                          txt: widget.menuItem?.itemName ?? "",
                          fontSize: 14,
                          weight: FontWeight.w400,
                          color: kTextPrimary,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        poppinsText(
                          txt: "₹ ${widget.menuItem?.itemPrice}",
                          fontSize: 10,
                          weight: FontWeight.w400,
                          color: kTextPrimary,
                        ),
                        poppinsText(
                          txt: widget.menuItem?.description ?? "",
                          fontSize: 10,
                          weight: FontWeight.w400,
                          color: kTextPrimary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: (widget.menuItem?.image == null ||
                              widget.menuItem?.image.length == 0)
                          ? Image.asset(
                              "assets/images/images_default_food_image.jpg",
                              fit: BoxFit.fill,
                              height: 72,
                              width: 72,
                            )
                          : Image.network(
                              widget.menuItem?.image ?? "",
                              fit: BoxFit.fill,
                              height: 72,
                              width: 72,
                            ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 50,
                    child: Card(
                      color: Colors.red,
                      elevation: 5, // You can adjust the elevation as needed
                      shape: const CircleBorder(),
                      child: InkWell(
                          onTap: widget.onAddTap,
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.add,
                              size: 15,
                            ),
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
