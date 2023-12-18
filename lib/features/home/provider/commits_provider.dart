import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_clone/features/home/model/commits_model.dart';
import 'package:http/http.dart' as http;

final commitsProvider = FutureProvider.autoDispose
    .family<List<CommitsModel>, String>((ref, url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    log(response.body);
    return commitsModelFromJson(response.body);
  } else {
    log(response.body);
    throw Exception("Failed to connect");
  }
});
