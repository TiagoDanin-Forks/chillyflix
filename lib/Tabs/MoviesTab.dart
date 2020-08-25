import 'package:chillyflix/Pages/DetailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chillyflix/Widgets/Cover.dart';
import 'package:chillyflix/Services/TolokaService.dart';

class MoviesTab extends StatefulWidget {
  @override
  _MoviesTabState createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {
  ScrollController _scrollController;
  int cursor;
  int page = 1;
  bool isLockedLoad = false;
  @override
  void initState() {
    _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureProvider<List<Movie>>(
        create: (_) {
          return Provider.of<TolokaService>(context).getMovies(page);
        },
        child: Consumer<List<Movie>>(
          builder: (context, data, _) {
            if (data != null) {
              return _buildGridView(context, data);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildGridView(BuildContext context, List<Movie> values) {
    _scrollController.addListener(() {
      if (!isLockedLoad &&
          _scrollController.offset /
                  _scrollController.position.maxScrollExtent >
              0.5) {
        isLockedLoad = true;
        page++;
        TolokaService().getMovies(page).then((movies) => movies.forEach((movie) {
              values.add(movie);
            }));
        isLockedLoad = false;
        setState(() {});
      }
    });
    return OrientationBuilder(
      builder: (context, orientation) {
        int itemCount = orientation == Orientation.landscape ? 6 : 3;
        return GridView.builder(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: itemCount, childAspectRatio: 0.501),
          itemCount: values.length,
          itemBuilder: (BuildContext context, int index) {
            Movie item = values[index];
            return Cover(
                item: item,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(item)));
                });
          },
          padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
        );
      },
    );
  }
}
