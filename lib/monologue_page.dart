import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:stream_provider/custom_alert_dialog.dart';
import 'package:web_socket_channel/io.dart';

// final messageProvider = StreamProvider.autoDispose((ref) async* {
//   final channel = IOWebSocketChannel.connect("ws://localhost:8081");
//   ref.onDispose(() => channel.sink.close());
//
//   await for (final value in channel.stream) {
//     yield value.toString();
//   }
// });

var monologueList = [];

class MonologuePage extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue<String> message = ref.watch(messageProvider);
    final monologueController = TextEditingController();
    final List<String> wordList = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("ひとり言アプリ"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: wordList.length,
        itemBuilder: (context, int index) {
          return Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: const Icon(Icons.chat),
              title: Text(wordList[index]),
            ),
          );
        },
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
    monologueList.add(controller.text);
    monologueList.forEach((element) {
      print(element);
    });
  }

  _cancelAction(BuildContext context) {
    print("閉じます");
  }
}
