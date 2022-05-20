import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStartedBackground extends StatelessWidget {
  const GetStartedBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 0.6,
        child: FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          clipBehavior: Clip.antiAlias,
          child: SvgPicture.asset('assets/images/bg_get_started.svg'),
        ),
      ),
    );
  }
}
