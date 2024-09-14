// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usersRepositoryHash() => r'7566749790c4eed2dfc97d82fc31548d851030a4';

/// See also [usersRepository].
@ProviderFor(usersRepository)
final usersRepositoryProvider = Provider<UsersRepository>.internal(
  usersRepository,
  name: r'usersRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usersRepositoryHash,
  dependencies: <ProviderOrFamily>[userIdNotifierProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    userIdNotifierProvider,
    ...?userIdNotifierProvider.allTransitiveDependencies
  },
);

typedef UsersRepositoryRef = ProviderRef<UsersRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
