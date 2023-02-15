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
      pinned: true,
      snap: true,
      floating: true,

      expandedHeight: context.deviceHeight(0.1),

      /// expandedHeight: 280,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Image.asset(
            AssetStrings.gptDarkIcon,
            color: AppColors.logoColor,
            scale: 14,
            // AssetStrings.gptIcon,
            // fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
