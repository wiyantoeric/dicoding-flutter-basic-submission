import 'package:renote/notes.dart';
import 'package:flutter/foundation.dart';

class NoteUpdateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? title;
  String? subtitle;
  String? content;
  final noteList = noteItems;
  final articleList = articleItems;

  set itemUpdate(SectionItem item) {
    item.title = (title ?? item.title);
    item.subtitle = (subtitle ?? item.subtitle);
    item.content = (content ?? item.content);
    notifyListeners();
  }

  set itemAdd(List<SectionItem> itemList) {
    itemList
        .add(SectionItem(title: title, subtitle: subtitle, content: content));
    notifyListeners();
  }

  void notifyUpdate() {
    notifyListeners();
  }
}
