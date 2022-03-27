import 'package:flutter/material.dart';
import 'package:renote/notes.dart';
import 'package:provider/provider.dart';
import 'package:renote/note_update_provider.dart';

class NoteEditScreen extends StatelessWidget {
  NoteEditScreen({Key? key, this.itemList, this.sectionItem}) : super(key: key);

  final List<SectionItem>? itemList;
  // Passed item
  SectionItem? sectionItem;

  // Cek tambah item atau edit item
  bool isAdding() => sectionItem == null;
  String? title;
  String? subtitle;
  String? content;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: ListView(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 18,
                                  color: Color.fromARGB(221, 66, 66, 66),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFA4EBF3)),
                                  foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(221, 66, 66, 66))
                                ),
                                child: Text(isAdding() ? 'Add' : 'Save'),
                                onPressed: () {
                                  if (!isAdding()) {
                                    updateItem(
                                        item: sectionItem!,
                                        title: title,
                                        subtitle: subtitle,
                                        content: content);
                                  } else {
                                    addItem(
                                        itemList: itemList!,
                                        title: title,
                                        subtitle: subtitle,
                                        content: content);
                                  }
                                  context
                                      .read<NoteUpdateProvider>()
                                      .notifyUpdate();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(noteUpdateSnackBar(isAdding() ? 'Note added!' : 'Update successful!'));
                                },
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          initialValue: (isAdding() ? null : sectionItem?.title),
                          decoration: const InputDecoration(hintText: 'Title'),
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                        TextFormField(
                          initialValue:
                              (isAdding() ? null : sectionItem?.subtitle),
                          decoration: const InputDecoration(hintText: 'Subtitle'),
                          onChanged: (value) {
                            subtitle = value;
                          },
                        ),
                        TextFormField(
                          initialValue:
                              (isAdding() ? null : sectionItem?.content),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Text here',
                          ),
                          onChanged: (value) {
                            content = value;
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void updateItem(
    {required SectionItem item,
    String? title,
    String? subtitle,
    String? content}) {
  item.title = (title ?? item.title);
  item.subtitle = (subtitle ?? item.subtitle);
  item.content = (content ?? item.content);
}

void addItem(
    {required List<SectionItem> itemList,
    String? title,
    String? subtitle,
    String? content}) {
  itemList.add(SectionItem(title: title, subtitle: subtitle, content: content));
}

Future<void> showAlertDialog(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );
    },
  );
}

SnackBar noteUpdateSnackBar(String message) => SnackBar(
      content: Text(message),
    );
