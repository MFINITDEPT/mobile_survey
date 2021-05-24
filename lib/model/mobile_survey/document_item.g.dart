// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocumentItemAdapter extends TypeAdapter<DocumentItem> {
  @override
  DocumentItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DocumentItem(
      path: fields[0] as String,
      dateTime: fields[1] as DateTime,
      formId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DocumentItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.formId);
  }

  @override
  int get typeId => 3;
}
