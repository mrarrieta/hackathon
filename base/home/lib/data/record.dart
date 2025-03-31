import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:floor/floor.dart';
import 'package:ui/tools/fixed_values.dart';

@entity
class Record {
  @primaryKey
  String? id;
  double? amount;
  String? description;
  String? referenceId;
  String? time;

  @ignore
  List<Record>? children;

  Record({this.id = "", this.amount = 0, this.description = "", this.referenceId, this.time});

  Record addChildren(List<Record> children) {
    this.children = children;
    return this;
  }

  bool isParent(){
    return referenceId != null && referenceId == "1";
  }

  bool isChild(){
    return referenceId != null && referenceId!.length > 1;
  }

  String getTime(){
    return time == null ? FixedValues.date.format(DateTime.now()) : time!;
  }

  String getId() {
    return id != null ? id! : "";
  }

  String getDescription() {
    return description != null ? description! : "";
  }

  double getAmount() {
    return amount != null ? amount! : 0.0;
  }

  Record clone(){
    return Record(
        id: ObjectId().toHexString(),
        amount: getAmount(),
        description: getDescription(),
        referenceId: referenceId,
        time: FixedValues.date.format(DateTime.now()),
    );
  }

  Record cloneAddChild(){
    return Record(
        id: ObjectId().toHexString(),
        amount: getAmount(),
        description: getDescription(),
        referenceId: referenceId,
        time: FixedValues.date.format(DateTime.now()),
    );
  }

  Record makeParent(String time) {
    referenceId = "1";
    amount = 0;
    this.time = time;
    return this;
  }

  Record add(double amount) {
    if(this.amount != null) {
      this.amount = this.amount! + amount;
    }
    return this;
  }

  Record addParent(Record parent) {
    referenceId = parent.getId();
    return this;
  }

  Record setAmount(double amount) {
    this.amount = amount;
    return this;
  }

  String getShortTime() {
    return getTime().length > 2 ? getTime().substring(2,getTime().length) : getTime();
  }

  bool isConsistent() {
    if(isParent() && getAmount() != 0.0) {
      return false;
    }
    return true;
  }

  Record fixRecord() {
    if(isParent() && getAmount() != 0.0) {
      amount = 0.0;
    }
    return this;
  }

  Record addData(
      String description,
      double? amount,
      String time,
      ) {
    id = getId().isEmpty ? ObjectId().toHexString() : getId();
    this.amount = isParent() ? 0 : amount;
    this.description = description;
    this.time = time;
    return this;
  }
}