import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repositories/users_repository.dart';

part 'users_repository.g.dart';


@Riverpod(keepAlive: true)
UsersRepository usersRepository(UsersRepositoryRef ref) => UsersRepository();