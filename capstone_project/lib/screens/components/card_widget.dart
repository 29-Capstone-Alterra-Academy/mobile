import 'dart:developer';

// import package
import 'package:flutter/material.dart';

// import model
import 'package:capstone_project/model/user_model.dart';
import 'package:capstone_project/model/thread_model.dart';
import 'package:capstone_project/model/category_model.dart';

// import theme & component
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/button_widget.dart';

/// CIRCLE PICTURE
Widget circlePic(double size, String img) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: NomizoTheme.nomizoDark.shade50,
      borderRadius: BorderRadius.circular(size / 2),
    ),
    clipBehavior: Clip.antiAlias,
    child: Image.network(
      img,
      errorBuilder: (context, error, stackTrace) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
        child: Image.asset('assets/img/app_logo.png', fit: BoxFit.contain),
      ),
      fit: BoxFit.cover,
    ),
  );
}

/// CATEGORY CARD
Widget categoryCard(BuildContext context, CategoryModel categoryModel) {
  return InkWell(
    onTap: () {
      // Navigator.pushNamed(context, '/detailCategory');
    },
    child: Container(
      height: 60,
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // image
          circlePic(52, categoryModel.profileImage!),
          const SizedBox(width: 8),
          // content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  categoryModel.name ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 2),
                // subtitle
                Text(
                  '${categoryModel.activityCount} Postingan',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: NomizoTheme.nomizoDark.shade500,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // button
          buttonSmall28(context, () {}, 'Ikuti'),
        ],
      ),
    ),
  );
}

/// USER CARD
Widget userCard(BuildContext context, UserModel userModel) {
  return InkWell(
    onTap: () {
      // Navigator.pushNamed(context, '/detailUser');
    },
    child: Container(
      height: 65,
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          // image
          circlePic(52, userModel.profileImage!),
          const SizedBox(width: 8),
          // content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  '@${userModel.username!}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 2),
                // subtitle
                Text(
                  'Nama Moderator',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: NomizoTheme.nomizoDark.shade500,
                      ),
                ),
                const SizedBox(height: 2),
                // subtitle2
                Text(
                  'Jumlah Folower',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: NomizoTheme.nomizoDark.shade500,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // button
          buttonSmall28(context, () {}, 'Ikuti'),
        ],
      ),
    ),
  );
}

/// ModalBottomSheet for Report / Follow Menu
Widget reportCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Container(
          width: 50,
          height: 2,
          color: NomizoTheme.nomizoDark.shade600,
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () {
            log('User berhasil dilaporkan');
          },
          child: SizedBox(
            height: 21,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                'Laporan',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    ),
  );
}

/// THREAD CARD
Widget threadCard(BuildContext context, ThreadModel threadModel) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.all(16),
      color: NomizoTheme.nomizoDark.shade50,
      child: Column(
        children: [
          // head thread
          Row(
            children: [
              // profile pic
              circlePic(42, threadModel.author!.profileImage!),
              const SizedBox(width: 7),
              // title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // posted by
                    Row(
                      children: [
                        Text(
                          threadModel.topic!.name!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Container(
                          width: 2,
                          height: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: NomizoTheme.nomizoDark.shade500,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'diposting oleh @${threadModel.author!.username}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: NomizoTheme.nomizoDark.shade500,
                                      fontWeight: FontWeight.w500,
                                    ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    // post time
                    Row(
                      children: [
                        Text(
                          'diposting',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: NomizoTheme.nomizoDark.shade500,
                                  ),
                        ),
                        Container(
                          width: 2,
                          height: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: NomizoTheme.nomizoDark.shade500,
                          ),
                        ),
                        Text(
                          '${threadModel.createdAt} hari lalu',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: NomizoTheme.nomizoDark.shade500,
                                  ),
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // more
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return reportCard(context);
                    },
                  );
                },
                icon: Icon(
                  Icons.more_horiz,
                  color: NomizoTheme.nomizoDark.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // thread content
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  threadModel.title ?? '...',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 4),
                // content
                Text(
                  '${threadModel.content}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // image
          if (threadModel.images!.isNotEmpty)
            ListView.builder(
                itemCount: threadModel.images!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 175,
                    child: Image.network(
                      threadModel.images![0],
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                            'https://picsum.photos/seed/picsum/300/200');
                      },
                      fit: BoxFit.contain,
                    ),
                  );
                }),
          const SizedBox(height: 12),
          // like / dislike / comment / share
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // comment
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/detailPost');
                },
                child: Row(
                  children: [
                    const Icon(Icons.comment_outlined),
                    const SizedBox(width: 4),
                    Text(
                      '999',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              // like
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(Icons.thumb_up_outlined),
                    const SizedBox(width: 4),
                    Text(
                      '999',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              // dislike
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(Icons.thumb_down_outlined),
                    const SizedBox(width: 4),
                    Text(
                      '999',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              // share
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
