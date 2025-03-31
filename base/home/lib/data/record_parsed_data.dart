import 'package:json_annotation/json_annotation.dart';

part 'record_parsed_data.g.dart';

@JsonSerializable()
class RecordParsedData {
  String? date;
  String? store;
  List<RecordItem>? items;

  RecordParsedData({required this.date, required this.store, required this.items});

  factory RecordParsedData.empty() {
    return RecordParsedData(
        date: null,
        store: null,
        items: []
    );
  }

  factory RecordParsedData.fromJson(Map<String, dynamic> json) => _$RecordParsedDataFromJson(json);
  Map<String, dynamic> toJson() => _$RecordParsedDataToJson(this);
}

@JsonSerializable()
class RecordItem {
  String? amount;
  String? price;
  String? description;

  RecordItem({required this.amount, required this.price, required this.description});

  factory RecordItem.fromJson(Map<String, dynamic> json) => _$RecordItemFromJson(json);
  Map<String, dynamic> toJson() => _$RecordItemToJson(this);
}