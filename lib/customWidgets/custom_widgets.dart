import 'package:flutter/material.dart';
import 'package:food_app/utils/Dimens.dart';
import 'package:food_app/utils/size_config.dart';

import '../utils/constants/app_constants.dart';

class HomeScreenTextTitle extends StatefulWidget {
  final title;

  const HomeScreenTextTitle({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreenTextTitle> createState() => _HomeScreenTextTitleState();
}

class _HomeScreenTextTitleState extends State<HomeScreenTextTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.defaultSize! * Dimens.size2,
        left: SizeConfig.defaultSize! * Dimens.size2,
        bottom: SizeConfig.defaultSize! * Dimens.size1,
      ),
      child: Text(
        widget.title,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: AppConstant.fontBold),
      ),
    );
  }
}
