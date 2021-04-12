// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchModelAdapter extends TypeAdapter<SearchModel> {
  @override
  SearchModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchModel(
      title: fields[0] as String,
      itemList: (fields[1] as List)?.cast<String>(),
      value: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SearchModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.itemList)
      ..writeByte(2)
      ..write(obj.value);
  }
  @override
  // TODO: implement typeId
  int get typeId => 1;
}
