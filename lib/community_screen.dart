import 'package:flutter/material.dart';
import 'package:renote/community_list.dart';
import 'package:renote/drawer_menu.dart';
import 'package:intl/intl.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({required Community community, Key? key})
      : community = community;

  final Community community;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(community.name),
          backgroundColor: const Color(0xFF1c7c81),
          foregroundColor: const Color(0xFFCCF2F4),
        ),
        drawer: const AppDrawer(),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth <= 720) {
            return CommunityScreenContent(community, true);
          } else {
            return CommunityScreenContent(community, false);
          }
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class CommunityScreenContent extends StatelessWidget {
  CommunityScreenContent(this.community, this.isMobile, {Key? key}) : super(key: key);

  Community community;
  // Nama komunitas berbeda pada mobile dan wide screen
  bool isMobile;

  // Currency formater
  final formatter = NumberFormat('#,###,###');

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Jumbotron
        Container(
          color: const Color(0xFFCCF2F4),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    community.name,
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 36,
                    ),
                  ),
                  Text(
                    community.description ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '${formatter.format(community.members)} members',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              // Community image
              Image.asset(
                community.communityImage!,
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Post section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Post',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),

              // Post item column
              Column(
                children: community.posts!.map((post) {
                  return Card(
                    color: Colors.white,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile image
                          Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 2,
                                  color: Colors.black,
                                )),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(post.publisherImage!),
                              backgroundColor: Colors.white30,
                            ),
                          ),
                          const SizedBox(width: 18),

                          // Post description
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      post.publisher,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          postTime(post.time),
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                        const BookmarkButton(),
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  post.content,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BookmarkButton extends StatefulWidget {
  const BookmarkButton({Key? key}) : super(key: key);

  @override
  State<BookmarkButton> createState() => BookmarkButtonState();
}

class BookmarkButtonState extends State<BookmarkButton> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
          size: 18),
      onPressed: () => setState(() {
        isBookmarked = !isBookmarked;
      }),
    );
  }
}

String postTime(num time) {
  if (time >= 7200) {
    return '${time ~/ 3600} hours ago';
  } else if (time >= 3600) {
    return ' An hour ago';
  } else {
    return 'Few mins ago';
  }
}
