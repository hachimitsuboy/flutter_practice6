import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:stream_provider/custom_alert_dialog.dart';
import 'package:web_socket_channel/io.dart';

StreamController<String> stringStream = StreamController<String>();

final monologueProvider = StreamProvider.autoDispose<String>((ref) {
  final streamController = StreamController<String>();
  ref.onDispose(() => streamController.sink.close());

  return stringStream.stream;
});

var monologueList = [];

class MonologuePage extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {


    final monologue = ref.watch(monologueProvider);
    monologueList.add(monologue.toString());
    final monologueController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ひとり言アプリ"),
        centerTitle: true,
      ),
      body: monologue.when(
        data: (monologue) {
          return ListView.builder(
            itemCount: monologueList.length,
            itemBuilder: (context, int index) {
              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: const Icon(Icons.chat),
                  title: Text(monologueList[index].toString()),
                ),
              );
            },
          );
        },
        error: (err, stack) => Text("Error: $err"),
        loading: () => const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addMonologue(context, monologueController),
        child: const Icon(Icons.add),
      ),
    );
  }

  _addMonologue(BuildContext context, TextEditingController controller) {
    showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
              title: "新たなひとり言",
              contentWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    maxLength: 20,
                    decoration: const InputDecoration(
                      hintText: "ひとり言",
                    ),
                  ),
                ],
              ),
              defaultActionText: "完了",
              cancelActionText: "やめる",
              action: () => _submitAction(context, controller),
              cancelAction: () => _cancelAction(context),
            ));
  }

  _submitAction(BuildContext context, TextEditingController controller) {
    //Streamとやり方変わらなくないか？ StreamProviderの使用例全くない。。。
    stringStream.sink.add(controller.text);
  }

  _cancelAction(BuildContext context) {
    print("閉じます");
  }
}
