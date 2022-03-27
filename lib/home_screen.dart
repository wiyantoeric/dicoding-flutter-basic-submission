import 'package:flutter/material.dart';
import 'package:renote/note_edit.dart';
import 'package:renote/drawer_menu.dart';
import 'package:renote/note_update_provider.dart';
import 'package:renote/notes.dart';
import 'package:renote/user.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 760) {
            return const MobileHomeScreen();
          } else if (constraints.maxWidth <= 1100) {
            return const WideHomeScreen(listViewItems: 3, useGrid: false);
          } else {
            return const WideHomeScreen(listViewItems: 6, useGrid: true);
          }
        },
      ),
    );
  }
}

class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCCF2F4),
        foregroundColor: const Color.fromARGB(255, 66, 66, 66),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Welcome, ${user.username}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromARGB(255, 66, 66, 66),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              color: const Color.fromARGB(255, 66, 66, 66),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Your note column
                Column(
                  children: [
                    sectionTitle(
                        text: 'Your Note',
                        icon: Icons.add,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return NoteEditScreen(itemList: noteItems);
                          }));
                        }),
                    const SizedBox(height: 8),
                    // Notes card
                    const NoteItems(itemsCount: 2),
                  ],
                ),
                const SizedBox(height: 36),
                // Your articles column
                Column(
                  children: [
                    sectionTitle(
                        text: 'Your Articles',
                        icon: Icons.add,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return NoteEditScreen(itemList: articleItems);
                          }));
                        }),
                    // Articles card
                    const ArticlesListView(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}

class WideHomeScreen extends StatelessWidget {
  const WideHomeScreen(
      {Key? key, required this.listViewItems, required this.useGrid})
      : super(key: key);

  final listViewItems;
  final bool useGrid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFCCF2F4),
          foregroundColor: const Color.fromARGB(255, 66, 66, 66),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome, ${user.username}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 66, 66, 66),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                color: const Color.fromARGB(255, 66, 66, 66),
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Your note column
                  Column(
                    children: [
                      sectionTitle(
                          text: 'Your Note',
                          icon: Icons.add,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NoteEditScreen(itemList: noteItems);
                            }));
                          }),
                      const SizedBox(height: 8),
                      // Notes card
                      NoteItems(itemsCount: listViewItems),
                    ],
                  ),
                  const SizedBox(height: 36),
                  // Your articles column
                  Column(
                    children: [
                      sectionTitle(
                          text: 'Your Articles',
                          icon: Icons.add,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NoteEditScreen(itemList: articleItems);
                            }));
                          }),
                      // Articles card
                      useGrid ? const ArticlesGridView() : const ArticlesListView(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        drawer: const AppDrawer(),
      ),
    );
  }
}

Widget sectionItem({required SectionItem sectionItem, bool isNote = true}) {
  return Builder(
    builder: (context) => InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (sectionItem.title != null) ? limitedText(sectionItem.title!, isNote ? 16 : 36) : '',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                (sectionItem.subtitle != null) ? limitedText(sectionItem.subtitle!, 54) : '',
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteEditScreen(sectionItem: sectionItem),
          )),
    ),
  );
}

Widget sectionTitle(
    {required String text, IconData? icon, VoidCallback? onPressed}) {
  return Row(
    children: <Widget>[
      Text(
        text,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      IconButton(
        icon: Icon(icon),
        onPressed: onPressed ?? () {},
      ),
    ],
  );
}

class NoteItems extends StatefulWidget {
  const NoteItems({Key? key, required this.itemsCount}) : super(key: key);

  final int itemsCount;

  @override
  State<NoteItems> createState() => _NoteItemsState(itemsCount);
}

class _NoteItemsState extends State<NoteItems> {
  _NoteItemsState(this.itemsCount);
  final int itemsCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: GridView.count(
        childAspectRatio: 1.5,
        crossAxisCount: itemsCount,
        children: context
            .watch<NoteUpdateProvider>()
            .noteList
            .map((note) => sectionItem(sectionItem: note))
            .toList(),
      ),
    );
  }
}

class ArticlesListView extends StatefulWidget {
  const ArticlesListView({Key? key}) : super(key: key);

  @override
  State<ArticlesListView> createState() => _ArticlesListViewState();
}

class _ArticlesListViewState extends State<ArticlesListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView(
        children: context
            .watch<NoteUpdateProvider>()
            .articleList
            .map((article) => sectionItem(sectionItem: article, isNote: false))
            .toList(),
      ),
    );
  }
}

class ArticlesGridView extends StatefulWidget {
  const ArticlesGridView({Key? key}) : super(key: key);

  @override
  State<ArticlesGridView> createState() => ArticlesGridViewState();
}

class ArticlesGridViewState extends State<ArticlesGridView> {
  ArticlesGridViewState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 6,
        children: context
            .watch<NoteUpdateProvider>()
            .articleList
            .map((article) => sectionItem(sectionItem: article))
            .toList(),
      ),
    );
  }
}

String limitedText(String a, int limit) {
  bool isLongString = a.length > limit ? true : false;

  return isLongString ? '${a.substring(0, limit)}...' : a.substring(0, a.length);
}
