import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renote/login.dart';
import 'package:renote/note_update_provider.dart';


void main() {
  runApp(
    ListenableProvider(
      create: (_) => NoteUpdateProvider(),
      child: const MaterialApp(
        home: Material(child: LoginScreen()),
      ),
    )
  );
}

