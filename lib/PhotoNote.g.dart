// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PhotoNote.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoNoteAdapter extends TypeAdapter<PhotoNote> {
  @override
  final int typeId = 0;

  @override
  PhotoNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoNote(
      fields[1] as String,
    )..imageNote = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, PhotoNote obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.imageNote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
