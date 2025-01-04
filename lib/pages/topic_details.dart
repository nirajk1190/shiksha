import 'package:flutter/material.dart';
import 'package:shiksha/pages/membership_screen.dart';
import 'package:shiksha/pages/pdf_view.dart';
import 'package:shiksha/util/ColorSys.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'full_screen_video_play.dart';

class TopicDetailsPage extends StatefulWidget {
  final String imagePath;
  final String topicName;
  final String topicDescription;
  final String pdfPath;
  final String videoUrl;

  const TopicDetailsPage({
    Key? key,
    required this.imagePath,
    required this.topicName,
    required this.topicDescription,
    required this.pdfPath,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _TopicDetailsPageState createState() => _TopicDetailsPageState();
}

class _TopicDetailsPageState extends State<TopicDetailsPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Extract video ID from the URL
    String videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false, // Do not autoplay until user starts
        mute: false, // Unmute the video
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  String getFileNameFromUrl(String url) {
    final uri = Uri.parse(url);
    final pathSegments = uri.pathSegments;
    return pathSegments.isNotEmpty ? pathSegments.last : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [

            // YouTube Video Section always visible
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            ),
            const SizedBox(height: 15),
            // Topic Name
            Text(
              widget.topicName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Topic Description with more padding and spacing
            Text(
              widget.topicDescription,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),

            // Course Videos List
            const Text(
              'Course Videos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            // List of video items
            ListView.builder(
              shrinkWrap: true,  // To allow scrolling inside ListView
              physics: NeverScrollableScrollPhysics(), // Disable outer scroll
              itemCount: 5, // Example count of courses
              itemBuilder: (context, index) {
                bool isLocked = index > 1; // Lock all items after the second one

                return Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),  // Border radius for rounded corners
                    border: Border.all(
                      color: Colors.grey, // Border color (you can adjust this to your needs)
                      width: 1, // Border width
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        // Image Preview on the left
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),  // Keep a reasonable radius for the image
                          child: Container(
                            width: 90,
                            height: 90,
                            child: Image.asset(
                              widget.imagePath,  // Use image for the preview
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Title, Description, and Button aligned to the right
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Video Title
                              Text(
                                'Course Video $index', // Update with actual title for each video
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),

                              // Video Description
                              Text(
                                'This is the description of video $index', // Replace with actual description
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 10),

                              // Watch Video Button or Locked Button
                              Row(
                                children: [
                                  // View Button
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: isLocked
                                          ? () {
                                        // Show a dialog when the button is clicked for locked items
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Membership Required',
                                                    style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),
                                                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                                                  ),
                                                ],
                                              ),
                                              content: const Text(
                                                'You need to purchase a membership to access this content.',
                                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context); // Close the dialog
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Navigate to the membership page or initiate purchase logic
                                                    Navigator.pop(context); // Close dialog after action
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => MembershipScreen(),
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: ColorSys.primary, // Customize button color
                                                  ),
                                                  child: const Text('Activate Premium',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14)),
                                                ),
                                              ],
                                            );
                                          },
                                        );


                                      }
                                          : () {
                                        // Show a dialog with options for View (normal functionality)
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PdfViewer(assetPath: widget.pdfPath),
                                          ),
                                        );

                                      },
                                      label: Text(
                                        'View',
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isLocked ?Colors.white: ColorSys.primary),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isLocked ? Colors.grey : Colors.white, // Grey for locked items
                                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                          side: BorderSide(color: isLocked? Colors.grey : ColorSys.primary, width: 1), // Border color and width
                                        ),
                                        elevation: 0, // Remove the shadow
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  // Watch Button or Locked Button
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: isLocked
                                          ? () {
                                        // Show a dialog when the button is clicked for locked items
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Membership Required',
                                                    style: TextStyle(fontWeight: FontWeight.w600),
                                                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                                                  ),
                                                ],
                                              ),
                                              content: const Text(
                                                'You need to purchase a membership to access this content.',
                                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context); // Close the dialog
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Navigate to the membership page or initiate purchase logic
                                                    Navigator.pop(context); // Close dialog after action
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => MembershipScreen(),
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: ColorSys.primary, // Customize button color
                                                  ),
                                                  child: const Text('Activate Premium',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14)),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                          : () {
                                        // Logic to watch the video
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FullScreenVideoPlayer(videoUrl: widget.videoUrl),
                                          ),
                                        );
                                      },
                                      label: const Text(
                                        'Watch',
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isLocked ? Colors.grey : ColorSys.primary,  // Grey for locked items
                                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
