import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/holiday/providers/holiday_providers.dart';

class HolidayListScreen extends ConsumerWidget {
  const HolidayListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holidaysAsync = ref.watch(holidaysProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Holidays'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/holidays/new'),
          ),
        ],
      ),
      body: holidaysAsync.when(
        data: (holidays) => ListView.builder(
          itemCount: holidays.length,
          itemBuilder: (context, index) {
            final holiday = holidays[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                leading: const Icon(Icons.event),
                title: Text(holiday.name),
                subtitle: Text(holiday.date),
                trailing: holiday.description != null
                    ? const Icon(Icons.info_outline)
                    : null,
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
