import 'package:distress/src/domain/entity.dart';

import '../types.dart';


abstract interface class EntityModel implements Entity {
	ObjectMap get object;
}
