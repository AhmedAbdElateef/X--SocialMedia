// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostAdapter extends TypeAdapter<Post> {
  @override
  final int typeId = 2;

  @override
  Post read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Post()
      ..likes = (fields[1] as List?)?.cast<dynamic>()
      ..commentsCount = fields[3] as int?
      ..id = fields[4] as String?
      ..text = fields[5] as String?
      ..userId = fields[6] as String?
      ..imageUrl = fields[7] as String?
      ..videoUrl = fields[8] as String?
      ..shares = (fields[2] as List?)?.cast<dynamic>()
      ..lastUpdated = fields[9] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.likes)
      ..writeByte(3)
      ..write(obj.commentsCount)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.text)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.videoUrl)
      ..writeByte(2)
      ..write(obj.shares)
      ..writeByte(9)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
