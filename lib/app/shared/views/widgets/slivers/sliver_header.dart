import 'package:chat_gpt/app/shared/helpers/dimensions.dart';
import 'package:chat_gpt/app/shared/views/widgets/slivers/sliver_delegate.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomSliverPersistentHeader extends ConsumerStatefulWidget {
  const CustomSliverPersistentHeader({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CustomSliverPersistentHeader> createState() =>
      _CustomSliverPersistentHeaderState();
}

class _CustomSliverPersistentHeaderState
    extends ConsumerState<CustomSliverPersistentHeader> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: context.deviceHeight(0.38),
        maxHeight: context.deviceHeight(0.38),
        child: const SizedBox.shrink(),

        /// minHeight: 360,
        /// maxHeight: 360,
        // CustomSliverPersistentHeader(),            // CustomSliverPersistentHeader(),,
      ),
    );
  }
}
