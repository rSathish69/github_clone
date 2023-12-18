import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../model/org_list_model.dart';

final orgListProvider =
    FutureProvider.autoDispose<List<OrganisationListModel>>((ref) async {
  //no need for this
  // final headre = {"Authorisation": "Bearer ${Sharedpref.getAccessToken}"};
  // in Github response gave OAuth access token only
  // we cannot access organisation list for authenticated user withour Personal access token
  // https://api.github.com/user/orgs this is a url for get organisation list for authenticated user
  // so i used this url.
  final response = await http.get(
    Uri.parse(
      //Sharedpref.getOrgListUrl,
      "https://api.github.com/users/defunkt/orgs",
    ),
    //headers: headre,
  );

  if (response.statusCode == 200) {
    log(response.body);
    return organisationListModelFromJson(response.body);
  } else {
    log(response.body);
    throw Exception("Failed to connect");
  }
});
