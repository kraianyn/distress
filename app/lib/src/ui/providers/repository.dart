import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:distress/src/data/repository.dart';

part 'repository.g.dart';


@Riverpod(keepAlive: true)
Repository repository(RepositoryRef ref) => Repository();
