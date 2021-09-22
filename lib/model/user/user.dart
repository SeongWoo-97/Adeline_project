import 'package:adeline_app/model/user/expenditionModel.dart';
import 'package:adeline_app/model/user/characterModel/characterModel.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  List<CharacterModel> characterList = [];
  @HiveField(1)
  ExpeditionModel? expeditionModel;

  User({required this.characterList, this.expeditionModel});
}
