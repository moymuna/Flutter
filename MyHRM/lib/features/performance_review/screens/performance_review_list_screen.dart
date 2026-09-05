import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/performance_review/providers/performance_review_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/shared/enums.dart';

class PerformanceReviewListScreen extends ConsumerWidget {
  const PerformanceReviewListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(performanceReviewsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Performance Reviews')),
      body: reviewsAsync.when(
        data: (reviews) => ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                title: Text(review.employeeName ?? 'N/A'),
                subtitle: Text(
                  'Period: ${review.reviewPeriod ?? 'N/A'} | '
                  'Rating: ${review.rating ?? 0}/5',
                ),
                trailing: StatusBadge(
                  label: review.status?.replaceAll('_', ' ') ?? 'PENDING',
                  color: _getStatusColor(review.status),
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    final s = ReviewStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => ReviewStatus.PENDING,
    );
    switch (s) {
      case ReviewStatus.COMPLETED:
        return Colors.green;
      case ReviewStatus.IN_PROGRESS:
        return Colors.blue;
      case ReviewStatus.PENDING:
        return Colors.orange;
      case ReviewStatus.ACKNOWLEDGED:
        return Colors.teal;
    }
  }
}
