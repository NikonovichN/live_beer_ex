import 'package:flutter/material.dart';

import 'package:vector_graphics/vector_graphics_compat.dart';

class SvgIcon extends StatelessWidget {
  final String assetName;
  final double? size;
  final Color? color;

  const SvgIcon({super.key, required this.assetName, this.size = 24.0, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: VectorGraphic(
        loader: AssetBytesLoader(assetName),
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
