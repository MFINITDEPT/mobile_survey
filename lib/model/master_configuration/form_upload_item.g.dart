// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_upload_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormUploadItemAdapter extends TypeAdapter<FormUploadItem> {
  @override
  FormUploadItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FormUploadItem(
      id: fields[0] as String,
      idForm: fields[1] as String,
      kode: fields[2] as String,
      kelengkapan: fields[3] as String,
      type: fields[4] as String,
      formName: fields[5] as String,
      count: fields[6] as int,
      creDate: fields[7] as String,
      creBy: fields[8] as String,
      modDate: fields[9] as String,
      modBy: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FormUploadItem obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.formName)
      ..writeByte(6)
      ..write(obj.count)
      ..writeByte(7)
      ..write(obj.creDate)
      ..writeByte(8)
      ..write(obj.creBy)
      ..writeByte(9)
      ..write(obj.modDate)
      ..writeByte(10)
      ..write(obj.modBy);
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;
}
