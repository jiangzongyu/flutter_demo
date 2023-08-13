import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Member {
  final String id;
  final String name;
  final String team;

  Member({required this.id, required this.name, required this.team});

  String get avatarUrl => 'https://www.snh48.com/images/member/zp_$id.jpg';

  @override
  String toString() => '$id: $name';
}

class SliverDemo extends StatefulWidget {
  const SliverDemo({super.key});

  @override
  State<SliverDemo> createState() => _SliverDemoState();
}

class _SliverDemoState extends State<SliverDemo> {
  List<Member> _members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SliverDemo'),
      ),
      // ListView.builder 实现
      // body: ListView.builder(
      //   itemBuilder: (BuildContext context, int index) {
      //     final m = _members[index];
      //     return ListTile(
      //       leading: ClipOval(
      //         child: CircleAvatar(
      //           radius: 32,
      //           backgroundColor: Colors.white,
      //           child: Image.network(m.avatarUrl),
      //         ),
      //       ),
      //       title: Text(m.name),
      //       subtitle: Text(m.id),
      //       trailing: Text(m.team),
      //     );
      //   },
      //   itemCount: _members.length,
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _members.clear();
          });
          const url = 'https://h5.48.cn/resource/jsonp/allmembers.php?gid=10';
          final res = await http.get(Uri.parse(url));
          if (res.statusCode != 200) {
            throw ('Error');
          }
          final json = convert.jsonDecode(res.body);
          final members = json['rows'].map<Member>(
            (row) => Member(
              id: row['sid'],
              name: row['sname'],
              team: row['tname'],
            ),
          );
          setState(() {
            _members = members.toList();
          });
          members.forEach((member) => print(member));
        },
        child: Scrollbar(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(),
              SliverPersistentHeader(
                delegate: _MyDelegate('team SII', const Color(0xff91cded)),
                pinned: true,
              ),
              // SliverToBoxAdapter(child: Center(child: Text('SII'))),
              _buildTeamList('SII'),
              SliverPersistentHeader(
                delegate: _MyDelegate('team NII', const Color(0xffae86bb)),
                pinned: true,
              ),
              // SliverToBoxAdapter(child: Center(child: Text('NII'))),
              _buildTeamList('NII'),
              SliverPersistentHeader(
                delegate: _MyDelegate('team HII', const Color(0xfff39800)),
                pinned: true,
              ),
              // SliverToBoxAdapter(child: Center(child: Text('HII'))),
              _buildTeamList('HII'),
              SliverPersistentHeader(
                delegate: _MyDelegate('team X', const Color(0xffa9cc29)),
                pinned: true,
              ),
              // SliverToBoxAdapter(child: Center(child: Text('X'))),
              _buildTeamList('X'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const url = 'https://h5.48.cn/resource/jsonp/allmembers.php?gid=10';
          final res = await http.get(Uri.parse(url));
          if (res.statusCode != 200) {
            throw ('Error');
          }
          final json = convert.jsonDecode(res.body);
          final members = json['rows'].map<Member>(
            (row) => Member(
              id: row['sid'],
              name: row['sname'],
              team: row['tname'],
            ),
          );
          setState(() {
            _members = members.toList();
          });
          members.forEach((member) => print(member));
        },
        tooltip: 'refresh all members',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  SliverGrid _buildTeamList(String teamName) {
    final teamMembers =
        _members.where((element) => element.team == teamName).toList();

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final m = teamMembers[index];
          return Column(
            children: [
              ClipOval(
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Image.network(m.avatarUrl),
                ),
              ),
              Text(m.name)
            ],
          );
        },
        childCount: teamMembers.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
    );
  }
}

class _MyDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final Color color;

  _MyDelegate(this.title, this.color);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: 32,
      color: color,
      child: FittedBox(child: Text(title)),
      // child: Text(title),
    );
  }

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(covariant _MyDelegate oldDelegate) => true;
}
