import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Member {
  final String id;
  final String name;
  final String team;
  final String pinyin;
  final String abbr;
  final String tid;
  final String tname;
  final String pid;
  final String pname;
  final String nickname;
  final String company;
  final String join_day;
  final String height;
  final String birth_day;
  final String star_sign_12;
  final String star_sign_48;
  final String birth_place;
  final String speciality;
  final String hobby;

  Member({
    required this.id,
    required this.name,
    required this.team,
    required this.pinyin,
    required this.abbr,
    required this.tid,
    required this.tname,
    required this.pid,
    required this.pname,
    required this.nickname,
    required this.company,
    required this.join_day,
    required this.height,
    required this.birth_day,
    required this.star_sign_12,
    required this.star_sign_48,
    required this.birth_place,
    required this.speciality,
    required this.hobby,
  });

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
              pinyin: row['pinyin'],
              abbr: row['abbr'],
              tid: row['tid'],
              tname: row['tname'],
              pid: row['pid'],
              pname: row['pname'],
              nickname: row['nickname'],
              company: row['company'],
              join_day: row['join_day'],
              height: row['height'],
              birth_day: row['birth_day'],
              star_sign_12: row['star_sign_12'],
              star_sign_48: row['star_sign_48'],
              birth_place: row['birth_place'],
              speciality: row['speciality'],
              hobby: row['hobby'],
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
              SliverPersistentHeader(
                delegate: _MyDelegate('预备生', Colors.grey[400]!),
                pinned: true,
              ),
              // SliverToBoxAdapter(child: Center(child: Text('X'))),
              _buildTeamList('预备生'),
            ],
          ),
        ),
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
          // 与GestureDetector 功能类似，InkWell 点击时有水波纹效果
          return InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DetailPage(member: m),
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: m.avatarUrl,
                  child: ClipOval(
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: Image.network(m.avatarUrl),
                    ),
                  ),
                ),
                Text(m.name)
              ],
            ),
          );
        },
        childCount: teamMembers.length,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
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

class DetailPage extends StatelessWidget {
  final Member member;

  const DetailPage({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(member.name),
      // ),
      // 第一种用 Column
      // body: Column(
      //   children: [
      //     _buildInfo("拼音", member.pinyin),
      //     _buildInfo("加入所属", member.tname),
      //     _buildInfo("昵称", member.nickname),
      //     _buildInfo("公司", member.company),
      //     _buildInfo("加入日期", member.join_day),
      //     _buildInfo("身高", '${member.height}cm'),
      //     _buildInfo("生日", member.birth_day),
      //     _buildInfo("星座", member.star_sign_12),
      //     _buildInfo("出生地", member.birth_place),
      //     _buildInfo("特长", member.speciality),
      //     _buildInfo("兴趣爱好", member.hobby),
      //   ],
      // ),
      // 第二种用 SliverToBoxAdapter
      // body: CustomScrollView(
      //   slivers: [
      //     SliverToBoxAdapter(
      //       child: Column(
      //         children: [
      //           _buildInfo("拼音", member.pinyin),
      //           _buildInfo("加入所属", member.tname),
      //           _buildInfo("昵称", member.nickname),
      //           _buildInfo("公司", member.company),
      //           _buildInfo("加入日期", member.join_day),
      //           _buildInfo("身高", '${member.height}cm'),
      //           _buildInfo("生日", member.birth_day),
      //           _buildInfo("星座", member.star_sign_12),
      //           _buildInfo("出生地", member.birth_place),
      //           _buildInfo("特长", member.speciality),
      //           _buildInfo("兴趣爱好", member.hobby),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // leading 自定义后退按钮
            // leading: BackButton(color: Colors.red),
            pinned: true,
            expandedHeight: 300,
            backgroundColor: Colors.pink[100],
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'SNH48-${member.name}',
                style: TextStyle(color: Colors.grey[800]),
              ),
              background: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://img.freepik.com/free-vector/detailed-hand-painted-pink-watercolour-background_1048-17039.jpg?w=2000',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 2,
                        color: Colors.pink[50],
                      ),
                      Expanded(child: SizedBox())
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Hero(
                          tag: member.avatarUrl,
                          child: Material(
                            shape: CircleBorder(),
                            elevation: 8.0,
                            child: ClipOval(
                              child: Image.network(member.avatarUrl,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildInfo("拼音", member.pinyin),
                _buildInfo("加入所属", member.tname),
                _buildInfo("昵称", member.nickname),
                _buildInfo("公司", member.company),
                _buildInfo("加入日期", member.join_day),
                _buildInfo("身高", '${member.height}cm'),
                _buildInfo("生日", member.birth_day),
                _buildInfo("星座", member.star_sign_12),
                _buildInfo("出生地", member.birth_place),
                _buildInfo("特长", member.speciality),
                _buildInfo("兴趣爱好", member.hobby),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildInfo(String label, String content) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(label),
            Text(
              content,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
