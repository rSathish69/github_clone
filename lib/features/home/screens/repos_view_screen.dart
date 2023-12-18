import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_clone/configuration/app_colors.dart';
import 'package:github_clone/configuration/app_styles.dart';
import 'package:github_clone/configuration/applayout.dart';
import 'package:github_clone/features/home/provider/branches_provider.dart';
import 'package:github_clone/utils/date_format.dart';
import 'package:github_clone/utils/error_widget.dart';
import 'package:github_clone/utils/loading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'branch_list.dart';

class ProjectDetail extends ConsumerStatefulWidget {
  final String commitsUrl;
  final String repoName;
  final String ownerAvatar;
  final String ownerName;
  final String lastUpdate;
  final String branchUrl;
  const ProjectDetail({
    super.key,
    required this.commitsUrl,
    required this.repoName,
    required this.ownerAvatar,
    required this.ownerName,
    required this.lastUpdate,
    required this.branchUrl,
  });

  @override
  ConsumerState<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends ConsumerState<ProjectDetail> {
  int tabLen = 0;
  tabLength() async {
    final len = await ref.read(branchesProvider(widget.branchUrl).future);
    tabLen = len.length;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tabLength();
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final branch = ref.watch(branchesProvider(widget.branchUrl));

    return DefaultTabController(
      length: tabLen,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: Text(
            "Project",
            style: AppStyles(context).titleLarge.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 196 - 56),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 196 - 56,
                    child: Padding(
                      padding: AppLayout.screenPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              widget.repoName,
                              style: AppStyles(context).titleMedium.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                            ),
                            subtitle: Text(
                              widget.ownerName,
                              style: AppStyles(context).bodysmall.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                            ),
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    color: const Color(0xFFEDEDFF),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.network(
                                  widget.ownerAvatar,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Last update:${widget.lastUpdate.dateFormat()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
        body: Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: branch.when(
                  loading: () => const Loader(),
                  error: (error, stackTrace) =>
                      ErrorWid(errorText: error.toString()),
                  data: (data) {
                    return TabBar(
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      isScrollable: true,
                      tabs: List.generate(
                        data.length,
                        (index) => Container(
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? const Color(0xFF27274A)
                                : const Color(0xFFF3F4FF),
                            borderRadius: BorderRadius.circular(43),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                            child: Text(
                              data[index].name,
                              style: AppStyles(context).bodysmall.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : const Color(0xFF5F607E),
                                  ),
                            ),
                          ),
                        ),
                      ),
                      onTap: (value) {
                        setState(() {
                          selectedIndex = value;
                        });
                      },
                    );
                  },
                )),
            Expanded(
              child:SizedBox(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          tabLen,
                          (index) =>  BranchList(
                            commitUrl: widget.commitsUrl,
                          ),
                        ),
                      ),
                    ),
                  
            ),
          ],
        ),
      ),
    );
  }
}
