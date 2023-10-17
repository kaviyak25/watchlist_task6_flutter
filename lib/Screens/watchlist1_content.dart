import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_task6/Screens/watchlist_screen.dart';

import '../bloc/sorting_bloc.dart';

class Watchlist1Content extends StatefulWidget {
  @override
  _Watchlist1ContentState createState() => _Watchlist1ContentState();
}

class _Watchlist1ContentState extends State<Watchlist1Content> {
  late SortingBloc sortingBloc;
  bool isSortByIdAscending = true;

  @override
  void initState() {
    sortingBloc = BlocProvider.of<SortingBloc>(context);
    sortingBloc.add(OriginalDataEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortingBloc, SortingState>(
      builder: (context, state) {
        final sortedData = state.contacts;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    isSortByIdAscending = !isSortByIdAscending;
                    sortingBloc.add(
                      isSortByIdAscending
                          ? AscendingSortEvent()
                          : DescendingSortEvent(),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text('Sorting'),
                          Icon(
                            isSortByIdAscending
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sortedData.length,
                itemBuilder: (context, index) {
                  final stock = sortedData[index];
                  return Card(
                    margin: EdgeInsets.all(9.0),
                    elevation: 19.0,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://picsum.photos/200/300'),
                      ),
                      title: Text('${stock.name}'),
                      subtitle: Text(' ${stock.contacts}'),
                      trailing: Text('${stock.id}'),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
