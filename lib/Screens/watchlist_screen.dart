import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_task6/Screens/watchlist1_content.dart';

import '../bloc/sorting_bloc.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SortingBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Text('Watchlist1'),
              ),
              Tab(
                child: Text('Watchlist2'),
              ),
              Tab(
                child: Text('Watchlist3'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Watchlist1Content(),
            Center(child: Text('watchlist 2')),
            Center(child: Text('watchlist 3')),
          ],
        ),
      ),
    );
  }
}
