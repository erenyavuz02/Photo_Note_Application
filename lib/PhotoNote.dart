import 'dart:io';

import 'package:hive/hive.dart';

part 'PhotoNote.g.dart';

@HiveType(typeId: 0)
class PhotoNote extends HiveObject{


  @HiveField(1)
  String imagePath;

  @HiveField(2)
  String imageNote = "";

  PhotoNote(this.imagePath);

  File getPhotoFile(){
    return File(imagePath);

  }

}