// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_form.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoFormAdapter extends TypeAdapter<PhotoForm> {
  @override
  PhotoForm read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoForm(
      id: fields[0] as String,
      idForm: fields[1] as String,
      kode: fields[2] as String,
      kelengkapan: fields[3] as String,
      type: fields[4] as String,
      count: fields[5] as int,
      createBy: fields[6] as String,
      createDate: fields[7] as String,
      modDate: fields[8] as String,
      modBy: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoForm obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idForm)
      ..writeByte(2)
      ..write(obj.kode)
      ..writeByte(3)
      ..write(obj.kelengkapan)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.count)
      ..writeByte(6)
      ..write(obj.createBy)
      ..writeByte(7)
      ..write(obj.createDate)
      ..writeByte(8)
      ..write(obj.modDate)
      ..writeByte(9)
      ..write(obj.modBy);
  }

  @override
  // TODO: implement typeId
  int get typeId => 4;
}
