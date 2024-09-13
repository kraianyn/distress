import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repositories/schedule_repository.dart';

part 'schedule_repository.g.dart';


@Riverpod(keepAlive: true)
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) => ScheduleRepository();
