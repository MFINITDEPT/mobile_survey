// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quisioner_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuisionerItemAdapter extends TypeAdapter<QuisionerItem> {
  @override
  QuisionerItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuisionerItem(
      id: fields[0] as String,
      idQuisioner: fields[1] as String,
      idPertanyaan: fields[2] as String,
      pertanyaan: fields[3] as String,
      questionTypeFlag: fields[4] as int,
      creDate: fields[5] as String,
      creBy: fields[6] as String,
      modDate: fields[7] as String,
      modBy: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuisionerItem obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idQuisioner)
      ..writeByte(2)
      ..write(obj.idPertanyaan)
      ..writeByte(3)
      ..write(obj.pertanyaan)
      ..writeByte(4)
      ..write(obj.questionTypeFlag)
      ..writeByte(5)
      ..write(obj.creDate)
      ..writeByte(6)
      ..write(obj.creBy)
      ..writeByte(7)
      ..write(obj.modDate)
      ..writeByte(8)
      ..write(obj.modBy);
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;
}
