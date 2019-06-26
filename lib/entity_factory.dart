import 'package:flutter_study/model/nav_model_entity.dart';
import 'package:flutter_study/model/tree_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "NavModelEntity") {
      return NavModelEntity.fromJson(json) as T;
    } else if (T.toString() == "TreeEntity") {
      return TreeEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}