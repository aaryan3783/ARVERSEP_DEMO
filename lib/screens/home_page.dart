import 'package:flutter/material.dart';
import 'drawer_navigation.dart';

class HomePage extends StatefulWidget {
  final String userEmail;

  const HomePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of movies
  List<dynamic> movies = [
    {
      "_id": "67d27ccae125d6617da1cb18",
      "id": 1,
      "name": "Inception",
      "language": "English",
      "genre": "Sci-Fi",
      "category": "Movie",
      "duration": "2h 28m",
      "thumbnail":
          "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x941-191119145916-634-Little-Women-CE-111919.jpg?fit=around%7C634:941&output-quality=90&crop=634:941;center,top",
      "videoUrl": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"
    },
    {
      "_id": "67d27ccae125d6617da1cb19",
      "id": 2,
      "name": "Aspirants",
      "language": "Hindi",
      "genre": "Sci-Fi",
      "category": "webseries",
      "duration": "6h 28m",
      "thumbnail":
          "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x941-191119145917-634-Jumanji-Next-Level-CE-111919.jpg?fit=around%7C634:941&output-quality=90&crop=634:941;center,top",
      "videoUrl": "https://youtu.be/0Kl1ucZuSZ8?si=oQTkEovhNYueqX8C"
    },
    {
      "_id": "67d27ccae125d6617da1cb1a",
      "id": 3,
      "name": "PANCHYAT",
      "language": "Hindi",
      "genre": "Sci-Fi",
      "category": "webseries",
      "duration": "6h 28m",
      "thumbnail":
          "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x939-191119145918-634-Last-Christmas-CE-111919.jpg?fit=around%7C634:940&output-quality=90&crop=634:940;center,top",
      "videoUrl": "https://youtu.be/T0vBY9SNAWU?si=qWrfEQDzS645wgDG"
    },
    {
      "_id": "67d27ccae125d6617da1cb1b",
      "id": 4,
      "name": "The Family",
      "language": "Hindi",
      "genre": "Sci-Fi",
      "category": "webseries",
      "duration": "10h 28m",
      "thumbnail":
          "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x939-191119145914-634-Ford-v-Ferrari-CE-111919.jpg?fit=around%7C634:940&output-quality=90&crop=634:940;center,top",
      "videoUrl": "https://youtu.be/T0vBY9SNAWU?si=qWrfEQDzS645wgDG"
    }
  ];

  // List of banner images for the carousel
  final List<String> bannerImages = [
    'https://tinyurl.com/3e57tjjm',
    'https://tinyurl.com/42akprz6',
    'https://images.unsplash.com/photo-1485846234645-a62644f84728?q=80&w=2070&auto=format&fit=crop',
    'https://tinyurl.com/ykazvk62',
    'https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=2070&auto=format&fit=crop',
  ];

  // State for the carousel
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Start auto-scroll when the widget is initialized
    startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Auto-scroll logic
  void startAutoScroll() {
    Future.delayed(Duration(seconds: 2), () {
      if (_pageController.hasClients && mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % bannerImages.length;
        });
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
        startAutoScroll(); // Recursive call to keep auto-scrolling
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          "ARE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Show the search bar when the search icon is pressed
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(movies: movies),
              );
            },
          ),
        ],
      ),
      drawer: DrawerNavigation(userEmail: widget.userEmail),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bannerSection(),
            sectionTitle("HOLLYWOOD"),
            movieList(),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bannerSection() {
    return Stack(
      children: [
        // Carousel using PageView
        SizedBox(
          width: double.infinity,
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: bannerImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                bannerImages[index],
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                },
              );
            },
          ),
        ),
        // Gradient overlay
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        // Dots indicator
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bannerImages.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = entry.key;
                  });
                  _pageController.animateToPage(
                    entry.key,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        // Text and buttons overlay
        Positioned(
          bottom: 10,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "DEMO",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "kuk · Demo · 2025 03-12 test5",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    child: Text(
                      "PLAY",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 70),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      "+ MY LIST",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget movieList() {
    return SizedBox(
      height: 120,
      child: movies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return movieItem(
                  context,
                  movies[index]['thumbnail'],
                  movies[index]['videoUrl'],
                );
              },
            ),
    );
  }

  Widget movieItem(BuildContext context, String imagePath, String videoUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/video_player',
          arguments: {'videoUrl': videoUrl},
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imagePath,
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: "Favorite",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.child_care),
          label: "Kids",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library),
          label: "Library",
        ),
      ],
    );
  }
}

// Custom SearchDelegate for movie search
class MovieSearchDelegate extends SearchDelegate<String> {
  final List<dynamic> movies;

  MovieSearchDelegate({required this.movies});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Close the search bar
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filter movies based on the search query
    final List<dynamic> searchResults = movies
        .where((movie) =>
            movie['name'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.black,
      child: searchResults.isEmpty
          ? Center(
              child: Text(
                'No movies found',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      movie['thumbnail'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 50,
                        );
                      },
                    ),
                  ),
                  title: Text(
                    movie['name'],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  subtitle: Text(
                    '${movie['language']} • ${movie['duration']}',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  onTap: () {
                    // Navigate to the video player with the movie's video URL
                    Navigator.pushNamed(
                      context,
                      '/video_player',
                      arguments: {'videoUrl': movie['videoUrl']},
                    );
                  },
                );
              },
            ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types (same as buildResults in this case)
    return buildResults(context);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            titleLarge: TextStyle(color: Colors.white, fontSize: 20),
          ),
    );
  }
}