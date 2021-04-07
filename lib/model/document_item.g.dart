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
    );
  }

  @override
  void write(BinaryWriter writer, DocumentItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

  @override
  // TODO: implement typeId
  int get typeId => 5;
}
