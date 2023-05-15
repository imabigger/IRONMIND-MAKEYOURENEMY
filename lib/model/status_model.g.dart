// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusModelAdapter extends TypeAdapter<StatusModel> {
  @override
  final int typeId = 1;

  @override
  StatusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatusModel(
      comList: (fields[0] as List).cast<String>(),
      timeInterval: fields[1] as TimeInterval,
    )
      ..startTime = fields[2] as int
      ..endTime = fields[3] as int
      ..countWin = fields[4] as int
      ..countConsecutiveWin = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, StatusModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.comList)
      ..writeByte(1)
      ..write(obj.timeInterval)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.countWin)
      ..writeByte(5)
      ..write(obj.countConsecutiveWin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TimeBoxModelAdapter extends TypeAdapter<TimeBoxModel> {
  @override
  final int typeId = 3;

  @override
  TimeBoxModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeBoxModel(
      boxList: (fields[0] as List).cast<TimeBoxStatus>(),
    );
  }

  @override
  void write(BinaryWriter writer, TimeBoxModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.boxList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeBoxModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TimeIntervalAdapter extends TypeAdapter<TimeInterval> {
  @override
  final int typeId = 2;

  @override
  TimeInterval read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return TimeInterval.half;
      case 2:
        return TimeInterval.hour;
      case 3:
        return TimeInterval.nine;
      default:
        return TimeInterval.half;
    }
  }

  @override
  void write(BinaryWriter writer, TimeInterval obj) {
    switch (obj) {
      case TimeInterval.half:
        writer.writeByte(1);
        break;
      case TimeInterval.hour:
        writer.writeByte(2);
        break;
      case TimeInterval.nine:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeIntervalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TimeBoxStatusAdapter extends TypeAdapter<TimeBoxStatus> {
  @override
  final int typeId = 4;

  @override
  TimeBoxStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TimeBoxStatus.complete;
      case 1:
        return TimeBoxStatus.fail;
      case 2:
        return TimeBoxStatus.wait;
      default:
        return TimeBoxStatus.complete;
    }
  }

  @override
  void write(BinaryWriter writer, TimeBoxStatus obj) {
    switch (obj) {
      case TimeBoxStatus.complete:
        writer.writeByte(0);
        break;
      case TimeBoxStatus.fail:
        writer.writeByte(1);
        break;
      case TimeBoxStatus.wait:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeBoxStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
