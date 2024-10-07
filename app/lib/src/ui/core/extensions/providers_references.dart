import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:distress/src/data/repositories/schedule_repository.dart';
import 'package:distress/src/data/repositories/users_repository.dart';

import 'package:distress/src/domain/entities/course.dart';
import 'package:distress/src/domain/entities/course_type.dart';
import 'package:distress/src/domain/entities/instructor.dart';
import 'package:distress/src/domain/entities/location.dart';
import 'package:distress/src/domain/user.dart';

import '../../states/home/providers/courses.dart';
import '../../states/home/providers/course_types.dart';
import '../../states/home/providers/instructors.dart';
import '../../states/home/providers/locations.dart';
import '../../states/home/providers/schedule_repository.dart';

import '../providers/app_state.dart';
import '../providers/user.dart';
import '../providers/users_repository.dart';


extension ProvidersReference on Ref {
	User? user({bool watch = true}) => watch
		? this.watch(userNotifierProvider)
		: read(userNotifierProvider);

	UsersRepository get usersRepository => read(usersRepositoryProvider);

	ScheduleRepository get scheduleRepository => read(scheduleRepositoryProvider);

	UserNotifier get userNotifier => read(userNotifierProvider.notifier);

	CoursesNotifier get coursesNotifier => read(coursesNotifierProvider.notifier);

	InstructorsNotifier get instructorsNotifier => read(instructorsNotifierProvider.notifier);
}

extension ProvidersWidgetReference on WidgetRef {
	User? user({bool watch = true}) => watch
		? this.watch(userNotifierProvider)
		: read(userNotifierProvider);

	AsyncValue<List<Course>> courses() => watch(coursesNotifierProvider);

	AsyncValue<List<CourseType>> courseTypes() => watch(courseTypesNotifierProvider);

	AsyncValue<List<Instructor>> instructors() => watch(instructorsNotifierProvider);

	AsyncValue<List<Location>> locations() => watch(locationsNotifierProvider);

	UsersRepository get usersRepository => read(usersRepositoryProvider);

	AppStateNotifier get appStateNotifier => read(appStateNotifierProvider.notifier);

	UserNotifier get userNotifier => read(userNotifierProvider.notifier);

	CoursesNotifier get coursesNotifier => read(coursesNotifierProvider.notifier);

	CourseTypesNotifier get courseTypesNotifier => read(courseTypesNotifierProvider.notifier);

	InstructorsNotifier get instructorsNotifier => read(instructorsNotifierProvider.notifier);

	LocationsNotifier get locationsNotifier => read(locationsNotifierProvider.notifier);
}
