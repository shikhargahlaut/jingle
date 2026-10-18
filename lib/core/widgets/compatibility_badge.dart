import 'package:flutter/material.dart';
import '../../data/models/media_compatibility_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Compatibility Match badge displaying percentage and opening full breakdown on tap.
class CompatibilityBadge extends StatelessWidget {
  final int score;
  final MediaCompatibilityModel? compatibility;
  final bool showLabel;
  final bool isInteractive;

  const CompatibilityBadge({
    super.key,
    required this.score,
    this.compatibility,
    this.showLabel = true,
    this.isInteractive = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isInteractive ? () => _showBreakdownModal(context) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.bolt,
              size: 14,
              color: Colors.black,
            ),
            const SizedBox(width: 4),
            Text(
              showLabel ? '$score% similar taste' : '$score% Match',
              style: AppTextStyles.caption.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBreakdownModal(BuildContext context) {
    final comp = compatibility ??
        MediaCompatibilityModel(
          overallScore: score,
          musicMatchPercentage: score,
          showMatchPercentage: (score * 0.9).toInt(),
        );

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Compatibility Breakdown',
                        style: AppTextStyles.heading.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.secondaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Match Tier & Score Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${comp.overallScore}%',
                          style: AppTextStyles.heading.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comp.tierLabel,
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Based on common music, shows, artists & interests',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Progress Bars for Music & Shows
              _buildMetricBar(
                title: 'Music Taste Compatibility',
                percentage: comp.musicMatchPercentage > 0
                    ? comp.musicMatchPercentage
                    : comp.overallScore,
                color: const Color(0xFF1DB954),
              ),
              const SizedBox(height: 10),
              _buildMetricBar(
                title: 'Shows & Movies Taste',
                percentage: comp.showMatchPercentage > 0
                    ? comp.showMatchPercentage
                    : (comp.overallScore * 0.88).toInt(),
                color: const Color(0xFFE50914),
              ),

              if (comp.sharedGenres.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Shared Genres',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: comp.sharedGenres.map((g) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.chipSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: Text(
                        g,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              if (comp.sharedArtists.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Shared Artists',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: comp.sharedArtists.map((a) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.chipSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: Text(
                        a,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              if (comp.sharedShows.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Shared Shows & Content',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: comp.sharedShows.map((s) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.chipSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: Text(
                        s,
                        style: AppTextStyles.caption.copyWith(
                          color: const Color(0xFF00C6FF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetricBar({
    required String title,
    required int percentage,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.secondaryText,
                fontSize: 11,
              ),
            ),
            Text(
              '$percentage%',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: (percentage / 100).clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: AppColors.cardSurface,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
