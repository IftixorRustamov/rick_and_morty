import 'package:flutter/material.dart';

import '../../../core/common/constants/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onToggle;
  final bool isLightTheme;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onToggle,
    required this.isLightTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder:
            (child, animation) =>
                ScaleTransition(scale: animation, child: child),
        child: IconButton(
          key: ValueKey(isFavorite),
          icon: Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color:
                isFavorite
                    ? mortyYellow
                    : (isLightTheme ? dimensionGrey : labWhite),
            size: 28,
          ),
          onPressed: onToggle,
          tooltip: isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
        ),
      ),
    );
  }
}
