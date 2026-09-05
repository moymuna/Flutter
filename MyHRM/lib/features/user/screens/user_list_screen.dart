import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/user/providers/user_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(filteredUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => context.push('/users/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              hint: 'Search users...',
              onChanged: (value) =>
                  ref.read(userSearchProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: usersAsync.when(
              data: (users) => ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          (user.fullName ?? 'U')[0].toUpperCase(),
                        ),
                      ),
                      title: Text(user.fullName ?? 'N/A'),
                      subtitle: Text(user.email ?? 'N/A'),
                      trailing: StatusBadge(
                        label: user.enabled == true ? 'ACTIVE' : 'INACTIVE',
                        color: user.enabled == true ? Colors.green : Colors.red,
                      ),
                      onTap: () => context.push('/users/${user.id}'),
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
