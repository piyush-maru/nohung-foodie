import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/presentation/screen/authentication_screens/verify_otp/verify_otp_screen.dart';
import 'package:food_app/presentation/screen/landing/landing_screen.dart';
import 'package:food_app/presentation/widgets/text_field/custom_text_field.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/Profile/get_profile.dart';

class UpdateProfile extends StatefulWidget {
  final String mobileNumber;
  final String email;
  final String name;
  final bool fromOtp;
  final String profilePic;

  const UpdateProfile(
      {Key? key,
      required this.mobileNumber,
      required this.email,
      required this.name,
      required this.profilePic,
      this.fromOtp = false})
      : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var email = TextEditingController();
  var name = TextEditingController();
  var mobileNumber = TextEditingController();
  var profilePic;
  Future<GetProfile?>? future;
  bool removeProfile = false;

  File? media;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    email.text = widget.email;
    name.text = widget.name;
    mobileNumber.text = widget.mobileNumber;
    profilePic = widget.profilePic;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 260,
        leading: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LandingScreen()),
                        (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(13.5),
                child: Image.asset(
                  'assets/images/white_backButton.png',
                  width: 24,
                ),
              ),
            ),
            poppinsText(
                txt: "Edit Profile",
                fontSize: 20,
                weight: FontWeight.w600,
                color: Colors.black),
          ],
        ),
        //title:  poppinsText(
        //    txt: "Edit Profile",
        //    fontSize: 20,
        //    weight: FontWeight.w600,
        //    color: Colors.black),
        // const Text(
        //   'Edit Profile',
        //   style: TextStyle(
        //       color: Colors.black, fontFamily: AppConstant.fontRegular),
        // ),
        elevation: 0,
        backgroundColor: AppConstant.appColor,
      ),
      backgroundColor: AppConstant.appColor,
      body: Stack(
        children: [
          Container(
            height: 200,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: media != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CircleAvatar(
                      child: Image.file(
                        File(media!.path),
                        fit: BoxFit.fill,
                        height: 140,
                        width: 150,
                      ),
                    ),
                  )
                : profilePic! == null ||
                        profilePic ==
                            "https://nohungtest.tech/assets/image/userprofile/noimage.png" ||
                        removeProfile == true
                    ? Image.asset(
                        "assets/images/delicious.png",
                        height: 150,
                        width: 150,
                      )
                    : CircleAvatar(
                        foregroundImage: NetworkImage(
                          profilePic!,
                          scale: 10,
                        ),
                      ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
                left: MediaQuery.of(context).size.width * 0.63),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppConstant.appColor, width: 5),
                shape: BoxShape.circle),
            child: IconButton(
              onPressed: () async {
                profilePop();
                //  XFile? image = await _picker.pickImage(source: source);
                //
                //  final File? file = File(image!.path);
                // image=file;
                //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//takePhoto(ImageSource.gallery);
              },
              icon: SvgPicture.asset(
                'assets/images/edit.svg',
                color: Colors.black,
                height: 20,
                width: 20,
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              children: [
                const SizedBox(
                  height: 12,
                ),
                CustomTextFieldFloatingLabel(
                  controller: name,
                  prefixIcon: Icons.face,
                  hint: 'Enter Name',
                  radius: 20,
                  textInputType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldFloatingLabel(
                  prefixIcon: Icons.phone_outlined,
                  controller: mobileNumber,
                  hint: "Enter Mobile Number",
                  textInputType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s")),
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFieldFloatingLabel(
                  prefixIcon: Icons.email_outlined,
                  controller: email,
                  hint: "Enter Email",
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (name.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Name Can't be empty",
                            style:
                                TextStyle(fontFamily: AppConstant.fontRegular),
                          ),
                        ),
                      );
                    }
                    if (mobileNumber.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Mobile Number Can't be empty",
                            style:
                                TextStyle(fontFamily: AppConstant.fontRegular),
                          ),
                        ),
                      );
                    }
                    if (email.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Email Can't be empty",
                            style:
                                TextStyle(fontFamily: AppConstant.fontRegular),
                          ),
                        ),
                      );
                    } else if (media != null) {
                      ApiProvider()
                          .updateProfileHttp(
                              name.text,
                              email.text,
                              mobileNumber.text,
                              removeProfile == false
                                  ? media!.path
                                  : "https://nohungtest.tech/assets/image/userprofile/noimage.png",
                              removeProfile == true ? "1" : "0")
                          .then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Profile Updated successfully',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: (Colors.black),
                          ));
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyOTPScreen(
                                mobileNumber: mobileNumber.text,
                                userID: '',
                                type: '',
                                forUpdateProfile: true,
                              ),
                            ),
                          );
                        }
                      });
                    } else {
                      ApiProvider()
                          .updateProfileStringHttp(
                              name.text,
                              email.text,
                              mobileNumber.text,
                              removeProfile == true ? "1" : "0")
                          .then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Profile Updated successfully',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: (Colors.black),
                          ));
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyOTPScreen(
                                mobileNumber: mobileNumber.text,
                                userID: '',
                                type: '',
                                forUpdateProfile: true,
                              ),
                            ),
                          );
                        }
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppConstant.appColor),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all(
                      const Size(400, 50),
                    ),
                  ),
                  child: const Text(
                    "UPDATE",
                    style: TextStyle(
                        fontSize: 18, fontFamily: AppConstant.fontRegular),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> profilePop() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              // Set rounded corners
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.only(left: 12, right: 0),
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Profile Picture",
                          style: TextStyle(fontFamily: AppConstant.fontRegular),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Image(
                            image: AssetImage("assets/images/yellow_cross.png"),
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ]),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppConstant.appColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          var image = await ImagePicker().pickImage(
                              source: ImageSource.gallery, imageQuality: 50);

                          setState(() {
                            media = File(image!.path);
                          });

                          // XFile? pic = await _picker.pickImage(source: ImageSource
                          //     .gallery);
                          // // image = await _picker.pickImage(source: ImageSource.gallery);
                          // setState(() {
                          //   image=pic;
                          //   profilePic = image;
                          // });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Upload",
                          style: TextStyle(fontFamily: AppConstant.fontRegular),
                        ),
                      ),
                      const SizedBox(width: 25),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            removeProfile = true;
                            Navigator.pop(context);
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Delete",
                          style: TextStyle(fontFamily: AppConstant.fontRegular),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
