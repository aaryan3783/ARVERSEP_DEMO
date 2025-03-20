import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'drawer_navigation.dart';
import 'video_player_page.dart';
// import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final String apiUrl = Platform.isAndroid?"http://10.0.2.2:8000/video":"http://localhost:8000/video";
  List<dynamic> movies = [
    {
        "_id": "67d27ccae125d6617da1cb18",
        "id": 1,
        "name": "Inception",
        "language": "English",
        "genre": "Sci-Fi",
        "category": "Movie",
        "duration": "2h 28m",
        "thumbnail": "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x941-191119145916-634-Little-Women-CE-111919.jpg?fit=around%7C634:941&output-quality=90&crop=634:941;center,top",
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
        "thumbnail": "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x941-191119145917-634-Jumanji-Next-Level-CE-111919.jpg?fit=around%7C634:941&output-quality=90&crop=634:941;center,top",
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
        "thumbnail": "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x939-191119145918-634-Last-Christmas-CE-111919.jpg?fit=around%7C634:940&output-quality=90&crop=634:940;center,top",
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
        "thumbnail": "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x939-191119145914-634-Ford-v-Ferrari-CE-111919.jpg?fit=around%7C634:940&output-quality=90&crop=634:940;center,top",
        "videoUrl": "https://youtu.be/T0vBY9SNAWU?si=qWrfEQDzS645wgDG"
    }
];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchMovies();
  // }

  // Future<void> fetchMovies() async {
  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));
  //     // print("fetching movie");
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = jsonDecode(response.body);
  //       setState(() {
  //         movies = data;
  //       });
  //     } else {
  //       print("Failed to load movies: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error fetching movies: $e");
  //   }
  // }

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
            onPressed: () {},
          ),
        ],
      ),
      drawer: DrawerNavigation(),
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
        Image.asset(
          'assets/banner.jpg',
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 300,
          color: Colors.black.withOpacity(0.3),
        ),
        Positioned(
          bottom: 20,
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
              SizedBox(height: 5),
              Text(
                "kuk · Demo · 2025 03-12 test5",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
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
                  SizedBox(width: 15),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerPage(videoUrl: videoUrl),
          ),
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