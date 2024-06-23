import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:plantie/models/diagnosis.dart';


class FileStorageService {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/diagnosis_history.json');
  }

  static Future<List<Diagnosis>> readDiagnosis() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String content = await file.readAsString();
        List<dynamic> jsonData = jsonDecode(content);
        return jsonData.map((item) => Diagnosis.fromJson(item)).toList();
      }
    } catch (e) {
      print("Error reading file: $e");
    }
    return [];
  }

  static Future<void> writeDiagnosis(List<Diagnosis> diagnosisList) async {
    try {
      final file = await _localFile;
      String jsonString =
          jsonEncode(diagnosisList.map((e) => e.toJson()).toList());
      await file.writeAsString(jsonString);
    } catch (e) {
      print("Error writing file: $e");
    }
  }

  static Future<void> addDiagnosis(Diagnosis newDiagnosis) async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        List<dynamic> jsonData = jsonDecode(await file.readAsString());
        jsonData.add(newDiagnosis.toJson());
        await file.writeAsString(jsonEncode(jsonData));
      } else {
        List<dynamic> jsonData = [newDiagnosis.toJson()];
        await file.writeAsString(jsonEncode(jsonData));
      }
    } catch (e) {
      print("Error adding diagnosis: $e");
    }
  }

  static Future<void> clearDiagnosis() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print("Error clearing file: $e");
    }
  }
}
