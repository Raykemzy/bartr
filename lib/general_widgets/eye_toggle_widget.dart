import 'package:bartr/features/login/presentation/notifier/visibility_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VisibilityIcon extends ConsumerStatefulWidget {
  const VisibilityIcon({Key? key}) : super(key: key);

  @override
  ConsumerState<VisibilityIcon> createState() => _VisibilityIconState();
}

class _VisibilityIconState extends ConsumerState<VisibilityIcon> {
  @override
  Widget build(BuildContext context) {
    var r = ref.read(visibilityProvider.notifier);
    var state = ref.watch(visibilityProvider);
    return InkWell(
      onTap: () => r.state = !r.state,
      child: state == true
          ? Image.asset('assets/images/visibility_off.png', scale: 7)
          : Image.asset('assets/images/visibility_on.png', scale: 7),
    );
  }
}
