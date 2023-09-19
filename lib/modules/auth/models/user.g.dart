// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SocialXUserAdapter extends TypeAdapter<SocialXUser> {
  @override
  final int typeId = 1;

  @override
  SocialXUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocialXUser()
      ..name = fields[1] as String?
      ..address = fields[2] as String?
      ..imageUrl = fields[3] as String?
      ..instagramLink = fields[4] as String?
      ..personalWebsiteLink = fields[5] as String?
      ..phoneNumber = fields[6] as String?
      ..facebookLink = fields[7] as String?
      ..email = fields[8] as String?
      ..bio = fields[9] as String?;
  }

  @override
  void write(BinaryWriter writer, SocialXUser obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.instagramLink)
      ..writeByte(5)
      ..write(obj.personalWebsiteLink)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.facebookLink)
      ..writeByte(8)
      ..write(obj.email)
      ..writeByte(9)
      ..write(obj.bio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialXUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
