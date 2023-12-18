import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_clone/configuration/app_assets.dart';
import 'package:github_clone/configuration/app_styles.dart';
import 'package:github_clone/configuration/applayout.dart';
import 'package:github_clone/features/home/widgets/cus_leading.dart';
import 'package:github_clone/utils/date_format.dart';
import '../../../utils/error_widget.dart';
import '../../../utils/loading.dart';
import '../provider/commits_provider.dart';

class BranchList extends ConsumerStatefulWidget {
  final String commitUrl;
  const BranchList({
    super.key,
    required this.commitUrl,
  });

  @override
  ConsumerState<BranchList> createState() => _BranchListState();
}

class _BranchListState extends ConsumerState<BranchList> {
  @override
  Widget build(BuildContext context) {
    final comm = ref.watch(commitsProvider(widget.commitUrl));
    return comm.when(
        loading: () => const Scaffold(
              body: Loader(),
            ),
        error: (error, stackTrace) =>
            Scaffold(body: ErrorWid(errorText: error.toString())),
        data: (data) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey.withOpacity(0.1),
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                isThreeLine: true,
                title: Text(
                  data[index].commit.message,
                  style: AppStyles(context).titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].commit.author.date.dateFormat(),
                      style: AppStyles(context).bodysmall.copyWith(
                            fontSize: 14,
                          ),
                    ),
                    AppLayout.spaceH10,
                    Row(
                      children: [
                        Image.asset(
                          AppAssets.icon,
                          width: 12,
                          height: 14,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          data[index].commit.author.name,
                          style: AppStyles(context).bodysmall.copyWith(
                                color: const Color(0xFF5F607E),
                              ),
                        )
                      ],
                    )
                  ],
                ),
                leading: const CustomLeading(
                  col: Color(0xFFFFF5EB),
                  image: AppAssets.folder,
                ),
              );
            },
          );
        });
  }
}
