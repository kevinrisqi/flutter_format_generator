// To parse this JSON data, do
//
//     final excelModel = excelModelFromJson(jsonString);

import 'dart:convert';

ExcelModel excelModelFromJson(String str) => ExcelModel.fromJson(json.decode(str));

String excelModelToJson(ExcelModel data) => json.encode(data.toJson());

class ExcelModel {
    String? range;
    String? majorDimension;
    List<List<String>>? values;

    ExcelModel({
        this.range,
        this.majorDimension,
        this.values,
    });

    factory ExcelModel.fromJson(Map<String, dynamic> json) => ExcelModel(
        range: json["range"],
        majorDimension: json["majorDimension"],
        values: json["values"] == null ? [] : List<List<String>>.from(json["values"]!.map((x) => List<String>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "range": range,
        "majorDimension": majorDimension,
        "values": values == null ? [] : List<dynamic>.from(values!.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
