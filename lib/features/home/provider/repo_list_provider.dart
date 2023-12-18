import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/repo_list_model.dart';

final repoListProvider = FutureProvider.autoDispose
    .family<List<RepoListModel>, String>((ref, repoUrl) async {
  final response = await http.get(Uri.parse(
    repoUrl,
  ));

  if (response.statusCode == 200) {
    log(response.body);
    return repoListModelFromJson(response.body);
  } else {
    log(response.body);
    throw Exception("Failed to connect");
  }
});

final saveRepoListProvider = StateProvider((ref) => "");
