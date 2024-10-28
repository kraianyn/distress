import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repositories/schedule_repository.dart';

part 'schedule_repository.g.dart';


@Riverpod(keepAlive: true)
ScheduleRepository scheduleRepository(Ref ref) => ScheduleRepository();
