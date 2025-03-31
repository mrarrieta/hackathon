// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_parsed_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordParsedData _$RecordParsedDataFromJson(Map<String, dynamic> json) =>
    RecordParsedData(
      date: json['date'] as String?,
      store: json['store'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => RecordItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecordParsedDataToJson(RecordParsedData instance) =>
    <String, dynamic>{
      'date': instance.date,
      'store': instance.store,
      'items': instance.items,
    };

RecordItem _$RecordItemFromJson(Map<String, dynamic> json) => RecordItem(
      amount: json['amount'] as String?,
      price: json['price'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$RecordItemToJson(RecordItem instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'price': instance.price,
      'description': instance.description,
    };
