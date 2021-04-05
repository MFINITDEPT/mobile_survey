// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zipcode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZipCodeModelAdapter extends TypeAdapter<ZipCodeModel> {
  @override
  ZipCodeModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ZipCodeModel(
      kota: fields[0] as String,
      kecamatan: fields[1] as String,
      kelurahan: fields[2] as String,
      kodePos: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ZipCodeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.kota)
      ..writeByte(1)
      ..write(obj.kecamatan)
      ..writeByte(2)
      ..write(obj.kelurahan)
      ..writeByte(3)
      ..write(obj.kodePos);
  }

  @override
  // TODO: implement typeId
  int get typeId => 4;
}
