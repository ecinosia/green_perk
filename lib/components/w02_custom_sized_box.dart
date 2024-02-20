import 'package:flutter/material.dart';

class W02CustomSizedBox extends StatelessWidget {
  const W02CustomSizedBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .02,
    );
  }
}
