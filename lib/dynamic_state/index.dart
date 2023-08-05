import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DynamicState extends StatefulWidget {
  const DynamicState({super.key});

  @override
  State<DynamicState> createState() => _DynamicStateState();
}

class _DynamicStateState extends State<DynamicState> {
  final _events = [];

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub最新动态'),
      ),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            return _refresh();
          },
          child: ListView(
            children: _events.map((e) {
              return Dismissible(
                confirmDismiss: (_) async {
                  return showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text('Do you want to delete this item?'),
                        actions: [
                          FloatingActionButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          FloatingActionButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text(
                              'Ok',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (_) {
                  setState(() {
                    _events.removeWhere((value) => e.id == value.id);
                  });
                },
                key: ValueKey(e.id),
                child: ListTile(
                  leading: Image.network(e.avatarUrl),
                  // leading: Image.network(
                  //     'https://himg.bdimg.com/sys/portrait/item/pp.1.f918e978.r7iG2pdfEj51kcMwhURfoQ?_t=1691244375876'),
                  title: Text(e.userName),
                  subtitle: Text(e.repoName),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final uri = Uri.https('api.github.com', '/events', {'q': '{https}'});
          final res = await http.get(uri);
          if (res.statusCode == 200) {
            final json = convert.jsonDecode(res.body);
            setState(() {
              _events.clear();
              _events.addAll(
                json.map(
                  (item) => GitEvent(
                    id: item["id"],
                    userName: item["actor"]["login"],
                    avatarUrl: item["actor"]["avatar_url"],
                    repoName: item["repo"]["name"],
                  ),
                ),
              );
            });
          }
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  _refresh() async {
    final uri = Uri.https('api.github.com', '/events', {'q': '{https}'});
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final json = convert.jsonDecode(res.body);
      setState(() {
        _events.clear();
        _events.addAll(
          json.map(
            (item) => GitEvent(
              id: item["id"],
              userName: item["actor"]["login"],
              avatarUrl: item["actor"]["avatar_url"],
              repoName: item["repo"]["name"],
            ),
          ),
        );
      });
    }
  }
}

class GitEvent {
  String id;
  String userName;
  String avatarUrl;
  String repoName;

  GitEvent({
    required this.id,
    required this.userName,
    required this.avatarUrl,
    required this.repoName,
  });

  @override
  String toString() {
    print('xxxxxxxx');
    return 'GitEvent{id: $id, userName: $userName, avatarName: $avatarUrl, repoName: $repoName}';
  }
}
