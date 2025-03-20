// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  VideoPlayerPage({required this.videoUrl});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  YoutubePlayerController? _youtubeController;
  bool isYouTubeVideo = false;
  bool isLoading = true;

  Map<String, dynamic>? videoDetails;

  List<dynamic> data = [
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
      "videoUrl":
          "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"
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

  @override
  void initState() {
    super.initState();

    // Get video details
    videoDetails = data.firstWhere(
      (video) => video["videoUrl"] == widget.videoUrl,
      orElse: () => {},
    );

    // Check for YouTube or MP4
    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId != null) {
      isYouTubeVideo = true;
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: true,
          isLive: false,
          controlsVisibleAtStart: true,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } else {
      _videoController = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          _chewieController = ChewieController(
            videoPlayerController: _videoController!,
            autoPlay: true,
            looping: false,
            allowFullScreen: true,
            allowPlaybackSpeedChanging: true,
          );
          setState(() {
            isLoading = false;
          });
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Video Player",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : videoDetails == null
              ? Center(
                  child: Text("Video details not found",
                      style: TextStyle(color: Colors.white)),
                )
              : Column(
                  children: [
                    // Video Player Section
                    Container(
                      height: 350,
                      width: double.infinity,
                      child: isYouTubeVideo
                          ? YoutubePlayerBuilder(
                              player: YoutubePlayer(
                                controller: _youtubeController!,
                                showVideoProgressIndicator: true,
                              ),
                              builder: (context, player) {
                                return player;
                              },
                            )
                          : _chewieController != null &&
                                  _chewieController!
                                      .videoPlayerController.value.isInitialized
                              ? Chewie(
                                  controller: _chewieController!,
                                )
                              : Center(child: CircularProgressIndicator()),
                    ),
                    // Video Details Section
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                videoDetails!["name"] ?? "Unknown",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Genre: ${videoDetails!["genre"]}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Category: ${videoDetails!["category"]}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Duration: ${videoDetails!["duration"]}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
