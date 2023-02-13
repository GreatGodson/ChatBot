import 'package:chat_gpt/app/shared/helpers/dimensions.dart';
import 'package:chat_gpt/app/shared/utils/strings.dart';
import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      actions: [],

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36),
      ),

      pinned: true,
      snap: true,
      floating: true,

      expandedHeight: context.deviceHeight(0.2),

      /// expandedHeight: 280,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.fromLTRB(16, 24, 4.4, 0),
          // height: 56,
          // height: context.deviceHeight(0.056),
          width: double.infinity,
        ),
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          child: Image.asset(
            AssetStrings.gptDarkIcon,
            color: AppColors.logoColor,
            // AssetStrings.gptIcon,
            // fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
