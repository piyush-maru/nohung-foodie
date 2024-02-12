import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/ui_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.prefix,
    this.maxChar,
    this.maxLines,
    this.hint,
    this.onChanged,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  final String? prefix;
  final String? hint;
  final int? maxChar;
  final int? maxLines;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppConstant.appColor,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxChar),
      ],
      keyboardType: textInputType,
      style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 16,
          fontWeight: FontWeight.w500),
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:
              const BorderSide(width: 1, color: kYellowColor), //<-- SEE HERE
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black87, width: 1.0),
          // borderRadius: BorderRadius.circular(25.0),
        ),
        prefixText: prefix,
        hintText: hint,
        hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        prefixStyle: const TextStyle(color: Colors.transparent),
      ),
    );
  }
}

class CustomTextFieldFloatingLabel extends StatefulWidget {
  const CustomTextFieldFloatingLabel({
    Key? key,
    required this.controller,
    required this.prefixIcon,
    this.isObscure = false,
    this.readOnly = false,
    this.radius = 15,
    this.inputFormatters,
    required this.hint,
    required this.textInputType,
  }) : super(key: key);

  final IconData prefixIcon;
  final String hint;
  final List<TextInputFormatter>? inputFormatters;

  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isObscure;
  final bool readOnly;
  final double radius;

  @override
  State<CustomTextFieldFloatingLabel> createState() =>
      _CustomTextFieldFloatingLabelState();
}

class _CustomTextFieldFloatingLabelState
    extends State<CustomTextFieldFloatingLabel> {
  late bool obscureText;
  @override
  void initState() {
    super.initState();
    obscureText = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(widget.radius),
      shadowColor: Color(0x54cec8c8),
      child: TextField(
        readOnly: widget.readOnly,
        cursorColor: kYellowColor,
        inputFormatters: widget.inputFormatters,
        obscuringCharacter: '●',
        obscureText: obscureText,
        keyboardType: widget.textInputType,
        style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        controller: widget.controller,
        decoration: InputDecoration(
          labelStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          labelText: widget.hint,
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide:
                BorderSide(width: 2, color: kYellowColor), //<-- SEE HERE
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),

            borderSide: BorderSide(color: kYellowColor, width: 2.0),
            // borderRadius: BorderRadius.circular(25.0),
          ),
          suffixIcon: widget.isObscure
              ? InkWell(
                  onTap: () => setState(() => obscureText = !obscureText),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: !obscureText
                          ? Icon(
                              Icons.visibility,
                              color: kYellowColor,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: kSilverNight,
                            )),
                )
              : SizedBox(),
          prefixIcon: Icon(
            widget.prefixIcon!,
            color: kBorderColor,
          ),
          contentPadding: const EdgeInsets.all(16.0),
          // hintText: widget.hint,
          hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 18,
              fontWeight: FontWeight.w400),
          prefixStyle: const TextStyle(color: Colors.transparent),
        ),
      ),
    );
  }
}

class CustomTextFieldPhone extends StatefulWidget {
  const CustomTextFieldPhone({
    Key? key,
    required this.controller,
    required this.prefixIcon,
    required this.hint,
    this.inputFormatters,
    required this.textInputType,
  }) : super(key: key);

  final Widget prefixIcon;
  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextFieldPhone> createState() => _CustomTextFieldPhoneState();
}

class _CustomTextFieldPhoneState extends State<CustomTextFieldPhone> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15),
      shadowColor: Color(0x54cec8c8),
      child: TextField(
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.textInputType,
        cursorColor: kYellowColor,
        style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        controller: widget.controller,
        decoration: InputDecoration(
          labelStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          labelText: widget.hint,
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(width: 2, color: kYellowColor), //<-- SEE HERE
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),

            borderSide: BorderSide(color: kYellowColor, width: 2.0),
            // borderRadius: BorderRadius.circular(25.0),
          ),
          prefix: widget.prefixIcon!,

          contentPadding: const EdgeInsets.all(16.0),
          // hintText: widget.hint,
          hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 18,
              fontWeight: FontWeight.w400),
          prefixStyle: const TextStyle(color: Colors.transparent),
        ),
      ),
    );
  }
}
