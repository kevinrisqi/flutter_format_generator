import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:format_generator/pages/excel_model.dart';

class HomeServices {
  Future<ExcelModel> fetchDataFromSpreadsheet() async {
    try {
      const String spreadsheetId =
          '1us9w2y87Z3_XI1LlmliPcxNH6GAJoJ0KM653g4d32u0';
      const String sheetName = 'Inv. List';
      const String apiKey = 'AIzaSyCXFK8rRHFIfmmcFyC3_9g-UgIOJI4u7jY';

      const String apiUrl =
          'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/$sheetName?key=$apiKey';
      print('Api Url: $apiUrl');
      final response = await Dio().get(apiUrl);

      // log('Response: ${response.data}');

      return excelModelFromJson(jsonEncode(response.data));
    } on DioException catch (e) {
      if (e.response != null) throw e.response?.data['errors'][0];
      throw e.message ?? 'Errors';
    }
  }
}
