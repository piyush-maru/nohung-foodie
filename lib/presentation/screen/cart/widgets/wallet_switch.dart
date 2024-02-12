import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/cart_screen_class/cart_screen_model_class.dart';
import '../../../../providers/wallet_provider.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/ui_constants.dart';

class WalletSwitch extends StatelessWidget {
  final CartDetailsData data;
  const WalletSwitch(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: true);
    return Row(
      children: [
        Text(
          "Wallet",
          style: AppTextStyles.normalText.copyWith(fontSize: 16),
        ),
        Switch(
          activeColor: AppConstant.appColor,
          thumbColor: MaterialStateProperty.all(Colors.white),
          value: walletProvider.isWalletActive,
          onChanged: (value) {
            walletProvider.updateWhetherWalletActive();
          },
        ),
        const Spacer(),
        Text(
          "₹ ${data.walletBalance}",
          style: AppTextStyles.normalText.copyWith(
              fontSize: 16,
              color: walletProvider.isWalletActive
                  ? Colors.black
                  : Colors.black26),
        ),
      ],
    );
  }
}
