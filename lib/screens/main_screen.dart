import 'package:flutter/material.dart';
import 'package:movieapp/screens/movie_screen.dart';
import 'package:movieapp/utils/api.dart';
import 'package:movieapp/utils/dimension.dart';
import 'package:movieapp/utils/services.dart';
import 'package:movieapp/utils/typedefs.dart';
import 'package:movieapp/widgets/appbar.dart';
import 'package:movieapp/widgets/balanced_grid_view.dart';
import 'package:movieapp/widgets/movie_card.dart';
import 'package:movieapp/widgets/videoplayer.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dimension = Provider.of<Dimension>(context);
    int cols = 0;
    if (dimension.screenWidth > 1000) {
      cols = 6;
    } else if (dimension.screenWidth > 800 && dimension.screenWidth < 1000) {
      cols = 4;
    } else if (dimension.screenWidth > 600 && dimension.screenWidth < 800) {
      cols = 2;
    } else {
      cols = 1;
    }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dimension.getWidth(100),
              vertical: dimension.getHeight(25),
            ),
            child: FutureBuilder(
              future: services<API>().moviesList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No data available',
                      style: textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
                  );
                }
                final children = snapshot.data!;

                return GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                  ),
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    final movie = children[index];
                    return MovieCard(
                      title: movie['title'],
                      image: movie['image'],
                      movieScreen: (context) => MovieScreen(movie: movie),
                    );
                  },
                );

                //return BalancedGridView(
                //  columnCount: cols,
                //  children: [
                //    for (final movie in children)
                //      MovieCard(
                //        title: movie['title'],
                //        image: movie['image'],
                //        movieScreen: (context) => MovieScreen(movie: movie),
                //      ),
                //  ],
                //);
              },
            ),
          ),
        ),
      ),
    );
  }
}
