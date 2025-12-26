import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_sizes.dart';
import '../../config/app_strings.dart';
import '../../enums/loading_status.dart';
import '../../models/friend_model.dart';
import '../../providers/friend_provider.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    context.read<FriendProvider>().fetchFriends();
    context.read<FriendProvider>().fetchFriendRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myFriends),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              _showAddFriendDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<FriendProvider>(
        builder: (context, friendProvider, _) {
          if (friendProvider.status == LoadingStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: _loadFriends,
            child: CustomScrollView(
              slivers: [
                // Friend requests section
                if (friendProvider.friendRequests.isNotEmpty)
                  SliverToBoxAdapter(
                    child: _buildFriendRequestsSection(friendProvider),
                  ),

                // Friends list
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final friend = friendProvider.friends[index];
                      return _FriendTile(
                        friend: friend,
                        onRemove: () {
                          friendProvider.removeFriend(friend.id);
                        },
                      );
                    },
                    childCount: friendProvider.friends.length,
                  ),
                ),

                // Empty state
                if (friendProvider.friends.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.people_outline, size: 48),
                          SizedBox(height: AppSizes.paddingMedium),
                          Text('No friends yet'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFriendRequestsSection(FriendProvider friendProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMedium),
          child: Text(
            'Friend Requests',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: friendProvider.friendRequests.length,
          itemBuilder: (context, index) {
            final request = friendProvider.friendRequests[index];
            return _FriendRequestTile(
              friend: request,
              onAccept: () {
                friendProvider.acceptFriendRequest(request.id);
              },
              onReject: () {
                friendProvider.rejectFriendRequest(request.id);
              },
            );
          },
        ),
        const Divider(),
      ],
    );
  }

  void _showAddFriendDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.addFriend),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(
            hintText: AppStrings.email,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (emailController.text.isNotEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Friend request sent'),
                  ),
                );
              }
            },
            child: const Text(AppStrings.addFriend),
          ),
        ],
      ),
    );
    emailController.dispose();
  }
}

class _FriendTile extends StatelessWidget {
  final FriendModel friend;
  final VoidCallback onRemove;

  const _FriendTile({
    required this.friend,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(friend.avatarUrl),
      ),
      title: Text(friend.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          if (friend.lastKnownVenueName != null)
            Text(
              'at ${friend.lastKnownVenueName}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: friend.isOnline ? Colors.green : Colors.grey,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                friend.isOnline ? 'Online' : 'Offline',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text(AppStrings.removeFriend),
            onTap: onRemove,
          ),
        ],
      ),
    );
  }
}

class _FriendRequestTile extends StatelessWidget {
  final FriendModel friend;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _FriendRequestTile({
    required this.friend,
    required this.onAccept,
    required this.onReject,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(friend.avatarUrl),
      ),
      title: Text(friend.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: onAccept,
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onReject,
          ),
        ],
      ),
    );
  }
}
