import 'package:flutter/material.dart';

// Import indicator widgets (in file tree order)
import '../../../widgets/indicators/animated_dots.dart';
import '../../../widgets/indicators/banner_persistent_alert.dart';
import '../../../widgets/indicators/circular_progress_indicator.dart';
import '../../../widgets/indicators/linear_progress_indicator_determinate.dart';
import '../../../widgets/indicators/linear_progress_indicator_indeterminate.dart';
import '../../../widgets/indicators/shimmer_loading.dart';

class IndicatorsShowcase extends StatelessWidget {
  const IndicatorsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('⚪ Animated Dots'),
        SizedBox(height: 8),
        AnimatedDots(),
        SizedBox(height: 16),

        Text('🚨 Banner Persistent Alert'),
        SizedBox(height: 8),
        BannerPersistentAlert(message: 'This is a persistent alert.'),
        SizedBox(height: 16),

        Text('🌀 Circular Progress Indicator'),
        SizedBox(height: 8),
        AppCircularLoader(),
        SizedBox(height: 16),

        Text('📏 Linear Progress Indicator (Determinate)'),
        SizedBox(height: 8),
        DeterminateLinearProgress(value: 0.6),
        SizedBox(height: 16),

        Text('♾️ Linear Progress Indicator (Indeterminate)'),
        SizedBox(height: 8),
        IndeterminateLinearProgress(),
        SizedBox(height: 16),

        Text('✨ Shimmer Loading'),
        SizedBox(height: 8),
        ShimmerLoading(height: 100, width: double.infinity),
        SizedBox(height: 16),
      ],
    );
  }
}
