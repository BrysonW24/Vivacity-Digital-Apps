import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_sizes.dart';
import '../../config/app_strings.dart';
import '../../enums/loading_status.dart';
import '../../models/reward_model.dart';
import '../../providers/reward_provider.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  void initState() {
    super.initState();
    _loadRewards();
  }

  Future<void> _loadRewards() async {
    final rewardProvider = context.read<RewardProvider>();
    rewardProvider.fetchAvailableRewards();
    rewardProvider.fetchUserPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.rewards),
        elevation: 0,
      ),
      body: Consumer<RewardProvider>(
        builder: (context, rewardProvider, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Points card
                _buildPointsCard(context, rewardProvider),

                // Available rewards section
                _buildRewardsSection(
                  context,
                  'Available Rewards',
                  rewardProvider.availableRewards,
                  rewardProvider,
                ),

                // Redeemed rewards section
                if (rewardProvider.redeemedRewards.isNotEmpty)
                  _buildRewardsSection(
                    context,
                    'Redeemed Rewards',
                    rewardProvider.redeemedRewards,
                    rewardProvider,
                    isRedeemed: true,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPointsCard(BuildContext context, RewardProvider rewardProvider) {
    return Container(
      margin: const EdgeInsets.all(AppSizes.paddingMedium),
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Column(
        children: [
          const Text(
            'Your Points',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: AppSizes.paddingSmall),
          Text(
            '${rewardProvider.totalPoints}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.paddingMedium),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text('View History'),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsSection(
    BuildContext context,
    String title,
    List<RewardModel> rewards,
    RewardProvider rewardProvider, {
    bool isRedeemed = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.paddingMedium,
            AppSizes.paddingMedium,
            AppSizes.paddingMedium,
            AppSizes.paddingSmall,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            return _RewardCard(
              reward: rewards[index],
              onRedeem: () {
                if (!isRedeemed) {
                  _showRedeemConfirmation(context, rewards[index], rewardProvider);
                }
              },
              isRedeemed: isRedeemed,
            );
          },
        ),
      ],
    );
  }

  void _showRedeemConfirmation(
    BuildContext context,
    RewardModel reward,
    RewardProvider rewardProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Redeem Reward'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Redeem ${reward.title}?'),
            const SizedBox(height: AppSizes.paddingMedium),
            Text(
              'Points required: ${reward.pointsRequired}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              rewardProvider.redeemReward(reward);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reward redeemed successfully')),
              );
            },
            child: const Text(AppStrings.redeem),
          ),
        ],
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final RewardModel reward;
  final VoidCallback onRedeem;
  final bool isRedeemed;

  const _RewardCard({
    required this.reward,
    required this.onRedeem,
    required this.isRedeemed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingSmall,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppSizes.radiusSmall),
                  child: Image.network(
                    reward.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: AppColors.surface,
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
                const SizedBox(width: AppSizes.paddingMedium),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSizes.paddingSmall),
                      Text(
                        'at ${reward.venueName}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSizes.paddingSmall),
                      if (!isRedeemed)
                        Text(
                          '${reward.pointsRequired} points',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.paddingMedium),
            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isRedeemed ? null : onRedeem,
                child: Text(
                  isRedeemed ? 'Redeemed' : AppStrings.redeem,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
