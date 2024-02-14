import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edutech/ADMIN/Youtube/premium%20video.dart';
import 'package:flutter/material.dart';

import 'First premium video.dart';
import 'N videob.dart';
import 'S normal video.dart';

class Total_videos extends StatefulWidget {
  const Total_videos({super.key});

  @override
  State<Total_videos> createState() => _Total_videosState();
}

class _Total_videosState extends State<Total_videos> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.purple),
        body: Column(children: [
          Container(
            color: Colors.white60,
            child: TabBar(
              tabs: [
                Tab(child: Text('1st year')),
                Tab(child: Text('2nd year')),
              ],
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.purple,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Expanded(child: TabBarView(children: [First_year(), Second_year()]))
        ]),
      ),
    );
  }
}

class First_year extends StatelessWidget {
  const First_year({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(children: [
          TabBar(tabs: [
            Tab(child: Text('Video')),
            Tab(child: Text('Premium')),
          ]),
          Expanded(
            child: TabBarView(children: [Normal_video(), F_premium_video()]),
          )
        ]),
      ),
    );
  }
}

class Second_year extends StatelessWidget {
  const Second_year({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(children: [
          TabBar(tabs: [
            Tab(child: Text('Video')),
            Tab(child: Text('Premium')),
          ]),
          Expanded(
            child: TabBarView(children: [SNormal_video(), S_premium_video()]),
          )
        ]),
      ),
    );
  }
}
