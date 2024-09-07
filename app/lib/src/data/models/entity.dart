import 'package:distress/src/domain/entity.dart';

import '../schedule_repository.dart';


abstract interface class EntityModel implements Entity {
	ObjectMap get object;
}
