import 'package:adeline_app/model/user/expeditionModel.dart';
import 'package:hive/hive.dart';

import 'characterModel/characterModel.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  List<CharacterModel> characterList = [];
  @HiveField(1)
  ExpeditionModel? expeditionModel;

  User({required this.characterList, this.expeditionModel});
}
