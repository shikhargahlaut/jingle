import 'package:flutter/material.dart';
import '../../data/models/activity_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Compact activity icon card matching Swipe profile detail screenshot.
class ActivityCard extends StatelessWidget {
  final ActivityModel activity;

  const ActivityCard({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Icon(
                activity.title.contains('Drive')
                    ? Icons.directions_car
                    : Icons.hiking,
                size: 28,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            activity.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
