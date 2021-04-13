// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AoModelAdapter extends TypeAdapter<AoModel> {
  @override
  AoModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AoModel(
      code: fields[0] as String,
      cCode: fields[1] as String,
      isHO: fields[2] as String,
      descs: fields[3] as String,
      maxClientLoad: fields[4] as int,
      currentLoad: fields[5] as int,
      modDate: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AoModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.cCode)
      ..writeByte(2)
      ..write(obj.isHO)
      ..writeByte(3)
      ..write(obj.descs)
      ..writeByte(4)
      ..write(obj.maxClientLoad)
      ..writeByte(5)
      ..write(obj.currentLoad)
      ..writeByte(6)
      ..write(obj.modDate);
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;
}
