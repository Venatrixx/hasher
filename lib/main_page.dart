import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:crypto/crypto.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final inputController = TextEditingController();

  bool get hasOutput => inputController.text.trim() != "";
  String getOutput() {
    if (!hasOutput) return "";
    final bytes = utf8.encode(inputController.text);
    final digest = algorithm.convert(bytes);
    return digest.toString();
  }

  Hash algorithm = sha256;

  String getAlgorithmName(Hash algorithm) => switch (algorithm) {
    md5 => "MD5",
    sha256 => "SHA256",
    sha512 => "SHA512",
    sha512256 => "SHA512/256",
    _ => algorithm.toString(),
  };

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Symbols.tag_rounded), title: Text("Hasher")),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            spacing: 8,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: .circular(16)),
                        labelText: "raw string",
                        suffix: hasOutput
                            ? IconButton(
                                onPressed: () => setState(() {
                                  inputController.text = "";
                                }),
                                icon: Icon(Symbols.close_rounded),
                              )
                            : null,
                      ),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),

                  DropdownMenu(
                    initialSelection: algorithm,
                    inputDecorationTheme: Theme.of(context).inputDecorationTheme
                        .copyWith(
                          border: OutlineInputBorder(
                            borderRadius: .circular(16),
                          ),
                        ),
                    menuStyle: MenuStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: .circular(16)),
                      ),
                    ),
                    dropdownMenuEntries: [
                      for (final algorithm in [md5, sha256, sha512, sha512256])
                        DropdownMenuEntry(
                          value: algorithm,
                          label: getAlgorithmName(algorithm),
                        ),
                    ],
                    onSelected: (value) => setState(() {
                      algorithm = value ?? algorithm;
                    }),
                  ),
                ],
              ),

              ListTile(
                title: Text("Output"),
                subtitle: Text(getOutput()),
                trailing: hasOutput
                    ? IconButton(
                        tooltip: "Save to clipboard",
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: getOutput()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Saved hash to Clipboard!")),
                          );
                        },
                        icon: Icon(Symbols.content_copy_rounded),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
