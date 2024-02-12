mixin Assets {
  static AssetSvgs get svgs => AssetSvgs();
  static AssetImages get images => AssetImages();
  static AssetIcons get icons => AssetIcons();
  static AssetLotties get lotties => AssetLotties();
  static AssetLogos get logos => AssetLogos();
}

class AssetLotties {
  String location = 'assets/lotties';
}

class AssetSvgs {
  String location = 'assets/svgs';
}

class AssetImages {
  /// Location Path
  String location = 'assets/images';

  String get splashBG => '$location/image_splash_screen_bg.png';
}

class AssetIcons {
  /// Location Path
  String location = 'assets/icons';

  /// Icons
  String get nohungText => '$location/icon_nohung_text.png';
  String get savedSuccessfully => '$location/icon_successfully_saved.png';

  /// Bottom Nav Bar Icons
  String get home => '$location/bottom_nav_bar_icons/home_icon.png';
  String get homeSelected =>
      '$location/bottom_nav_bar_icons/bottam_home.png'; //icon_home_fill.png';
  String get cart => '$location/bottom_nav_bar_icons/cart_icon.png';
  String get cartSelected =>
      '$location/bottom_nav_bar_icons/bottam_cart.png'; //icon_cart_fill.png';
  String get orders => '$location/bottom_nav_bar_icons/order_history_icon.png';
  String get ordersSelected =>
      '$location/bottom_nav_bar_icons/bottam_Order_History.png'; //icon_orders_fill.png';
  String get profile => '$location/bottom_nav_bar_icons/Profile_icon.png';
  String get profileSelected =>
      '$location/bottom_nav_bar_icons/bottam_Profile.png'; //icon_profile_fill.png';
}

class AssetLogos {
  /// Location Path
  String location = 'assets/logos';

  String get logo => '$location/logo_foodie.png';
}
