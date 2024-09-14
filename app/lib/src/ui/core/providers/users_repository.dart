import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repositories/users_repository.dart';
import 'package:distress/src/domain/providers/user.dart';

part 'users_repository.g.dart';


@Riverpod(keepAlive: true, dependencies: [UserIdNotifier])
UsersRepository usersRepository(UsersRepositoryRef ref) =>
	UsersRepository(userId: ref.watch(userIdNotifierProvider)!);
