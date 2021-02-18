// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quisioner.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuisionerModelAdapter extends TypeAdapter<QuisionerModel> {
  @override
  QuisionerModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuisionerModel(
      question: fields[0] as String,
      choice: (fields[1] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuisionerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.choice);
  }

  @override
  // TODO: implement typeId
  int get typeId => 2;
}
