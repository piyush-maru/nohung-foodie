import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/customWidgets/help_screen.dart';
import 'package:food_app/network/login_api/login_api_controller.dart';
import 'package:food_app/network/profile_repo.dart';
import 'package:food_app/presentation/screen/Profile/refer_friend.dart';
import 'package:food_app/presentation/screen/Profile/terms_conditions.dart';
import 'package:food_app/presentation/screen/profile/update_profile.dart';
import 'package:food_app/presentation/screen/profile/wallet.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/Profile/get_profile.dart';
import '../../../model/cart_count_provider/cart_count_provider.dart';
import '../../../model/login.dart';
import '../../../network/pre_order/pre_order_provider.dart';
import '../../../res.dart';
import '../../../utils/Utils.dart';
import '../../../utils/helper_class.dart';
import '../../../utils/pref_manager.dart';
import '../../../utils/size_config.dart';
import '../../widgets/shimmer_container.dart';
import '../authentication_screens/login/login_with_mobile_screen.dart';
import '../landing/landing_screen.dart';
import '../location_collections/address_list_screen.dart';
import 'fav_kitchen_screen.dart';

class Profile extends StatefulWidget {
  // final Function refreshOrdersCallback;

  const Profile(
      {
      // required this.refreshOrdersCallback,
      Key? key})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<GetProfile?>? future;
  var like = false;
  var disLike = true;
  LoginModel? user;

  @override
  initState() {
    super.initState();
    final profileModel = Provider.of<ProfileModel>(context, listen: false);
    future = profileModel.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;
    final profileModel = Provider.of<ProfileModel>(context, listen: false);
    var loginApiController =
        Provider.of<LoginApiController>(context, listen: false);
    // loginApiController.name = username.toString();
    // loginApiController.number = number.toString();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LandingScreen()),
            (route) => false);
        return false;
      },
      child: FutureBuilder<GetProfile?>(
          future: profileModel.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: topPadding,
                          color: AppConstant.appColor,
                        ),
                        Container(
                          height: 120,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: AppConstant.appColor,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "My Account",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppConstant.fontRegular,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        ColoredBox(
                          color: AppConstant.appColor,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    Text(
                                      snapshot.data!.data[0].username,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapshot.data!.data[0].email,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          // fontFamily: AppConstant.fontBold,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapshot.data!.data[0].mobileNumber,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateProfile(
                                              mobileNumber: snapshot
                                                  .data!.data[0].mobileNumber,
                                              email:
                                                  snapshot.data!.data[0].email,
                                              name: snapshot
                                                  .data!.data[0].username,
                                              profilePic: snapshot
                                                  .data!.data[0].profilePic
                                                  .toString(),
                                              //call:getProfileDetails,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 25,
                                          width: 60,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color: AppConstant.appColor,
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                SvgPicture.asset(
                                                    'assets/images/edit.svg'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth,
                                      child: SingleChildScrollView(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Wallet(snapshot
                                                              .data!
                                                              .data[0]
                                                              .myWallet),
                                                    ),
                                                  );
                                                },
                                                child: const ProfileItems(
                                                    imagePath:
                                                        "assets/images/wallet.svg",
                                                    name: "Wallet"),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddressListScreen(
                                                        fromProfileScreen: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const ProfileItems(
                                                    imagePath:
                                                        "assets/images/address-card.svg",
                                                    name: "Address List"),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FavKitchen(),
                                                    ),
                                                  );
                                                },
                                                child: const ProfileItems(
                                                    imagePath:
                                                        "assets/icons/icon_fav_kitchens.svg",
                                                    name:
                                                        "Favorite Kitchen's "),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const TermsAndConditions(),
                                                    ),
                                                  );
                                                },
                                                child: const ProfileItems(
                                                    imagePath:
                                                        "assets/icons/icon_t&c.svg",
                                                    name:
                                                        "Terms And Conditions"),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              // InkWell(
                                              //   onTap: () {},
                                              //   child: const ProfileItems(
                                              //       imagePath:
                                              //           "assets/icons/icon_info_rounded.svg",
                                              //       name: "About Us"),
                                              // ),
                                              // const SizedBox(
                                              //   height: 12,
                                              // ),
                                              InkWell(
                                                onTap: () {
                                                  Utils.shareContent(
                                                      Helper.shareAppContent());
                                                },
                                                child: const ProfileItems(
                                                    imagePath:
                                                        "assets/icons/icon_share.svg",
                                                    name: "Share the App"),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReferAFriend(
                                                        referralCode: snapshot
                                                            .data!
                                                            .data[0]
                                                            .referralCode
                                                            .toString(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const ProfileItems(
                                                    imagePath:
                                                        "assets/icons/icon_refer_a_friend.svg",
                                                    name: "Refer a friend"),
                                              ),
                                              const SizedBox(height: 12),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HelpScreen(),
                                                    ),
                                                  );
                                                },
                                                child: const ProfileItems(
                                                    imagePath:
                                                        "assets/images/help-center.svg",
                                                    name: "Help"),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  logout(context);
                                                },
                                                child: const ProfileItems(
                                                    imagePath:
                                                        "assets/images/logout.svg",
                                                    name: "Logout"),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: -50,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Color(0xffFFB300), width: 2)),
                                  height: 100,
                                  width: 100,
                                  child: ClipOval(
                                    child: Image.network(
                                      snapshot.data!.data[0].profilePic,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 45,
                        ),
                        Shimmer.fromColors(
                          // direction: ShimmerDirection.,
                          baseColor: const Color(0xd2eeecec),
                          highlightColor: const Color(0xd2fdfbfb),
                          child: const CircleAvatar(
                            radius: 70,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Shimmer.fromColors(
                          baseColor: const Color(0xd2eeecec),
                          highlightColor: const Color(0xd2fdfbfb),
                          child: const ShimmerContainer(
                            height: 35,
                            width: 150,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ...List.generate(
                            8,
                            (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: const Color(0xd2eeecec),
                                        highlightColor: const Color(0xd2fdfbfb),
                                        child: const ShimmerContainer(
                                          height: 50,
                                          width: double.infinity,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: topPadding,
                        color: AppConstant.appColor,
                      ),
                      Container(
                        height: 120,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        color: AppConstant.appColor,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Welcome to NOHUNG!",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppConstant.fontRegular,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      ColoredBox(
                        color: AppConstant.appColor,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 60,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      loginApiController.updateSkip();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const LoginWithMobileScreen(),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                    ),
                                    child: const Text(
                                      "Login / Sign Up",
                                      style: TextStyle(
                                          fontFamily: AppConstant.fontRegular),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HelpScreen(),
                                        ),
                                      );
                                    },
                                    child: const ProfileItems(
                                        imagePath:
                                            "assets/images/help-center.svg",
                                        name: "Help"),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  // InkWell(
                                  //   onTap: () {},
                                  //   child: const ProfileItems(
                                  //       imagePath:
                                  //           "assets/icons/icon_info_rounded.svg",
                                  //       name: "About Us"),
                                  // ),
                                  // const SizedBox(
                                  //   height: 12,
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Utils.shareContent(
                                          Helper.shareAppContent());
                                    },
                                    child: const ProfileItems(
                                        imagePath:
                                            "assets/icons/icon_share.svg",
                                        name: "Share the App"),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TermsAndConditions(),
                                        ),
                                      );
                                    },
                                    child: const ProfileItems(
                                        imagePath: "assets/icons/icon_t&c.svg",
                                        name: "Terms And Conditions"),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: -50,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xffFFB300), width: 2)),
                                height: 100,
                                width: 100,
                                child: Image.asset(
                                  "assets/images/delicious.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          }),
    );
  }

  getUserAddressList(result) {
    return Padding(
      padding: const EdgeInsets.only(left: 46, top: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            Res.location,
            width: 16,
            height: 16,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              result.address.toString(),
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                  fontFamily: AppConstant.fontRegular, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final preOrderProvider =
            Provider.of<PreorderProvider>(context, listen: false);

        return Dialog(
            child: Container(
                padding: const EdgeInsets.all(24),
                height: 250,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Logout_pop.svg",
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Are you sure want to logout',
                      style: TextStyle(fontFamily: AppConstant.fontBold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'NO',
                              style: TextStyle(
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFFFCC647))),
                            onPressed: () async {
                              var cartCountModel = Provider.of<CartCountModel>(
                                  context,
                                  listen: false);
                              cartCountModel.checkCartCount(
                                  count: 0, provider: preOrderProvider);

                              PrefManager.clear();
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/loginSignUp',
                                  (Route<dynamic> route) => false);
                            },
                            child: const Text(
                              'YES',
                              style: TextStyle(
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          )
                        ])
                  ],
                )));
      },
    );
  }
}

class ProfileItems extends StatelessWidget {
  final imagePath;
  final String name;

  const ProfileItems({Key? key, required this.imagePath, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      margin: const EdgeInsets.only(right: 8, top: 5, left: 8, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 24,
          ),
          SvgPicture.asset(
            imagePath,
            height: 20,
            width: 20,
            color: Colors.black, //AppConstant.appColor,
          ),
          const SizedBox(
            width: 24,
          ),
          Text(
            name,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: AppConstant.fontRegular,
                color: Colors.black),
          )
        ],
      ),
    );
  }
}
