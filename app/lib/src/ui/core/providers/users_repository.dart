import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:distress/src/data/repositories/users_repository.dart';

import '../extensions/providers_references.dart';

part 'users_repository.g.dart';


@Riverpod(keepAlive: true)
UsersRepository usersRepository(Ref ref) => UsersRepository(user: ref.user());
