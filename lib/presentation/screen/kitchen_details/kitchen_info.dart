import 'package:flutter/material.dart';
import 'package:food_app/utils/constants/app_constants.dart';

class KitchenInfo extends StatefulWidget {
  const KitchenInfo({Key? key}) : super(key: key);

  @override
  State<KitchenInfo> createState() => _KitchenInfoState();
}

class _KitchenInfoState extends State<KitchenInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: const Color(0xFFF6F6F6),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: ListView(
        padding: const EdgeInsets.only(left: 16,right: 16),
        children: [
          Container(
            height: 300,
            width: 400,
            padding: const EdgeInsets.only(top:24,left: 16,right: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.white),
            child:const Text("About",style: TextStyle(color: Colors.black,fontFamily: AppConstant.fontRegular,fontSize: 16,fontWeight: FontWeight.bold),)
          ),
          const SizedBox(height: 12,),
          Container(
            height: 300,
            width: 400,
              padding: const EdgeInsets.only(top:24,left: 16,right: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.white),
              child:const Text("Kitchen Info",style: TextStyle(color: Colors.black,fontFamily: AppConstant.fontRegular,fontSize: 16,fontWeight: FontWeight.bold),)
          ),
          const SizedBox(height: 12,),
          Container(
            height: 300,
            width: 400,
              padding: const EdgeInsets.only(top:24,left: 16,right: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.white),
              child:const Text("Open Timings",style: TextStyle(color: Colors.black,fontFamily: AppConstant.fontRegular,fontSize: 16,fontWeight: FontWeight.bold),)
          ),
          const SizedBox(height: 12,)

        ],
      ),
    );
  }
}
