import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_clone/configuration/app_colors.dart';
import 'package:github_clone/configuration/app_styles.dart';
import 'package:github_clone/configuration/applayout.dart';
import 'package:github_clone/features/home/provider/org_list_provider.dart';
import 'package:github_clone/features/home/provider/repo_list_provider.dart';
import 'package:github_clone/features/home/screens/repos_view_screen.dart';
import 'package:github_clone/features/home/widgets/cus_leading.dart';
import 'package:github_clone/features/home/screens/drawer_screen.dart';
import 'package:github_clone/utils/custom_snackbar.dart';
import 'package:github_clone/utils/error_widget.dart';
import 'package:github_clone/utils/loading.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String name;
  final String userName;
  final String proImage;
  final String company;
  const HomeScreen({
    super.key,
    required this.name,
    required this.userName,
    required this.proImage,
    required this.company,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String repoUrl = "";
  String errorText = "";

  getRepoUrl() async {
    final orgList = await ref.read(orgListProvider.future);
    if (orgList.isNotEmpty) {
      repoUrl = orgList[0].reposUrl;
      log(repoUrl);
      setState(() {});
    } else {
      errorText = "No Oraganisation Found";
      setState(() {});
      toast("No Oraganisation Found", isSuccess: false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRepoUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    final repoList = ref.watch(repoListProvider(
        ref.read(saveRepoListProvider).isEmpty
            ? repoUrl
            : ref.read(saveRepoListProvider)));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "GitHub",
          style: AppStyles(context).titleLarge.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final token =
                    await FirebaseAuth.instance.currentUser!.getIdToken(true);
                log(token!);
                // final appleProvider = AppleAuthProvider();
                // final user = await FirebaseAuth.instance
                //     .signInWithProvider(appleProvider);
                // final accessToken = user.credential?.accessToken;
                // log(accessToken!);
              },
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ))
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          width: MediaQuery.of(context).size.width - 82,
          child: DrawerScreen(
            name: widget.name,
            profilPic: widget.proImage,
            companyName: widget.company,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: AppLayout.screenPadding,
                color: AppColors.primaryColor,
                width: MediaQuery.of(context).size.width,
                height: 178 - 56,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi ${widget.userName}",
                      style: AppStyles(context).titleLarge.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
              repoUrl.isEmpty
                  ? const Expanded(
                      child: Loader(),
                    )
                  : Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: AppLayout.screenPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 54,
                                ),
                                Text(
                                  "Projects",
                                  style: AppStyles(context).titleSmall.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                repoList.when(
                                  loading: () => const Expanded(
                                    child: Loader(),
                                  ),
                                  error: (error, stackTrace) => Expanded(
                                      child: ErrorWid(
                                          errorText: error.toString())),
                                  data: (data) {
                                    return Column(
                                      children: List.generate(
                                        data.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.only(
                                            top: 16,
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProjectDetail(
                                                            branchUrl: data[index]
                                                                .branchesUrl
                                                                .replaceAll(
                                                                    "{/branch}",
                                                                    ""),
                                                            repoName:
                                                                data[index]
                                                                    .name,
                                                            ownerName:
                                                                data[index]
                                                                    .owner
                                                                    .login,
                                                            ownerAvatar:
                                                                data[index]
                                                                    .owner
                                                                    .avatarUrl,
                                                            lastUpdate:
                                                                data[index]
                                                                    .updatedAt,
                                                            commitsUrl: data[
                                                                    index]
                                                                .commitsUrl
                                                                .replaceAll(
                                                                    "{/sha}",
                                                                    "")),
                                                  ));
                                            },
                                            leading: CustomLeading(
                                              image:
                                                  data[index].owner.avatarUrl,
                                              networkImage: true,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: const BorderSide(
                                                color: Color(0xFFF6F5FE),
                                              ),
                                            ),
                                            title: Text(
                                              data[index].name,
                                              style: AppStyles(context)
                                                  .titleSmall
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            subtitle: Text(
                                              data[index].owner.login,
                                              style: AppStyles(context)
                                                  .bodysmall
                                                  .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
          Positioned(
            left: 15,
            top: 178 - 108,
            child: Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width - 30,
              height: 108,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 5),
                        spreadRadius: 2,
                        blurRadius: 30),
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFEDEDFF),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                        widget.proImage,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: AppStyles(context).titleMedium.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color(0xFF22CCCC),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Text(
                            widget.company,
                            style: AppStyles(context).bodysmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
