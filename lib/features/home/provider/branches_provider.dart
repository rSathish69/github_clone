import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../model/branches_model.dart';

final branchesProvider = FutureProvider.autoDispose
    .family<List<BranchesModel>, String>((ref, url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    log(response.body);
    return branchesModelFromJson(response.body);
  } else {
    log(response.body);
    throw Exception("Failed to connect");
  }
});
