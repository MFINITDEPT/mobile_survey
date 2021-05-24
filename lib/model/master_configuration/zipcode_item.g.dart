// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zipcode_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZipCodeItemAdapter extends TypeAdapter<ZipCodeItem> {
  @override
  ZipCodeItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ZipCodeItem(
      sysZipId: fields[0] as int,
      kota: fields[1] as String,
      kecamatan: fields[2] as String,
      kelurahan: fields[3] as String,
      kodePos: fields[4] as String,
      areaTagih: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ZipCodeItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.sysZipId)
      ..writeByte(1)
      ..write(obj.kota)
      ..writeByte(2)
      ..write(obj.kecamatan)
      ..writeByte(3)
      ..write(obj.kelurahan)
      ..writeByte(4)
      ..write(obj.kodePos)
      ..writeByte(5)
      ..write(obj.areaTagih);
  }


  @override
  int get typeId => 2;
}
