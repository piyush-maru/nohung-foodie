import 'package:flutter/material.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:timelines/timelines.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({Key? key}) : super(key: key);

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appColor,
        title: const Text(
          'Order Status',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Timeline.tileBuilder(
        builder: TimelineTileBuilder.fromStyle(
          indicatorStyle: IndicatorStyle.outlined,
          contentsAlign: ContentsAlign.basic,
          contentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Timeline Event $index',
              selectionColor: Colors.green,
            ),
          ),
          itemCount: 100,
        ),
      ),
    );
  }
}
