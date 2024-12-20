import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/ui/core/extensions/providers_references.dart';

part 'course_archive_months.g.dart';


@Riverpod(keepAlive: true)
Future<List<DateTime>> courseArchiveMonths(Ref ref) async {
	final months = await ref.scheduleRepository.courseArchiveMonths();
	return months..sort((a, b) => b.compareTo(a));
}
