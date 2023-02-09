import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// custom search text form field

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      shadowColor: AppColors.primaryColor,
      color: AppColors.primaryColor,
      child: TextFormField(
        onChanged: onChanged,
        controller: textEditingController,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
        keyboardType: TextInputType.text,
        cursorColor: AppColors.whiteColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.textFormFillColor,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          suffixIcon: IconButton(
              onPressed: () {},
              icon: Transform.rotate(
                angle: -45 * math.pi / 180,
                child: Icon(
                  Icons.send,
                  color: Theme.of(context).iconTheme.color,
                ),
              )
              // icon: SvgPicture.asset('assets/icons/searchIcon.svg'),
              ),

          // icon: SvgPicture.asset('assets/icons/searchIcon.svg'),
        ),
      ),
    );
  }
}
