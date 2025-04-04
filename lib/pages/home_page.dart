import 'package:flutter/material.dart';
import 'package:shiksha/pages/topic_details.dart';
import 'package:shiksha/util/ColorSys.dart';

import '../model/category_model.dart';
import '../model/topic_model.dart';

class SectionModel {
  final String name;
  final List<TopicModel> topics;

  SectionModel({required this.name, required this.topics});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CategoryModel> subjects = [
    CategoryModel(
      name: 'Physics',
      isSelected: false,
      sections: [
        SectionModel(
          name: 'Mechanics',
          topics: [
            TopicModel(name: 'Th Earth', imagePath: 'assets/earth.jpg',pdfPath: 'assets/the_earth.pdf',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'The Solar System', imagePath: 'assets/solar.jpg',pdfPath: 'assets/solar.pdf',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'The Structure of Earth', imagePath: 'assets/structure.jpg',pdfPath: 'assets/structure.pdf',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
          ],
        ),
        SectionModel(
          name: 'Optics',
          topics: [
            TopicModel(name: 'Refraction', imagePath: 'assets/img_4.jpg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'Reflection', imagePath: 'assets/img_4.jpg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'Lenses', imagePath: 'assets/img_4.jpg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
          ],
        ),
      ],
    ),
    CategoryModel(
      name: 'Mathematics',
      isSelected: false,
      sections: [
        SectionModel(
          name: 'Algebra',
          topics: [
            TopicModel(name: 'Linear Equations', imagePath: 'assets/img_3.jpg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'Quadratic Equations', imagePath: 'assets/img_3.jpg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'Polynomials', imagePath: 'assets/img_3.jpg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
          ],
        ),
        SectionModel(
          name: 'Calculus',
          topics: [
            TopicModel(name: 'Limits', imagePath: 'assets/img_3.jpg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'Derivatives', imagePath: 'assets/img_3.jpg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'Integrals', imagePath: 'assets/img_3.jpg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
          ],
        ),
      ],
    ),
    CategoryModel(
      name: 'Chemistry',
      isSelected: false,
      sections: [
        SectionModel(
          name: 'Organic Chemistry',
          topics: [
            TopicModel(name: 'Hydrocarbons', imagePath: 'assets/chem.jpeg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'Alcohols', imagePath: 'assets/chem.jpeg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'Aldehydes', imagePath: 'assets/chem.jpeg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
          ],
        ),
        SectionModel(
          name: 'Inorganic Chemistry',
          topics: [
            TopicModel(name: 'Periodic Table', imagePath: 'assets/chem.jpeg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'Acids and Bases', imagePath: 'assets/chem.jpeg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
            TopicModel(name: 'Chemical Bonding', imagePath: 'assets/chem.jpeg',pdfPath: '',videoUrl: 'https://www.youtube.com/watch?v=p8IE1279KyE',description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
          ],
        ),
      ],
    ),
    // Add more subjects with sections and topics
  ];

  @override
  void initState() {
    super.initState();
    // Set the first subject to be selected by default
    subjects[0].isSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3854BD), Color(0xFFA365DB)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 38, left: 18, right: 18),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Profile Navigation can be implemented here
                              },
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/hulk.jpg',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),
                            Text(
                              'Welcome',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: subjects.length,
                        itemBuilder: (context, index) {
                          final category = subjects[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // Deselect all categories and then select the clicked one
                                for (var cat in subjects) {
                                  cat.isSelected = false;
                                }
                                category.isSelected = true; // Select the clicked category
                              });
                            },
                            child: _buildButton(category.name, isSelected: category.isSelected),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30.0),
                    // Display Sections and Topics when a subject is selected
                    if (subjects.any((subject) => subject.isSelected))
                      ...subjects
                          .where((subject) => subject.isSelected)
                          .map((subject) => _buildSections(subject.sections)),
                  ],
                ),
              )
              // Horizontal ListView of Subjects

            ],
          ),
        )
    );
  }

  // Button style for Subjects
  Widget _buildButton(String title, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? ColorSys.primary : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? ColorSys.primary : Colors.grey),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Display a list of sections for the selected subject
  Widget _buildSections(List<SectionModel> sections) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            _buildTopicList(section.topics),
            SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }

  // Display a list of topics for the selected section
  Widget _buildTopicList(List<TopicModel> topics) {
    return Container(
      height: 120, // Adjust the height of the topic cards
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return GestureDetector(
            onTap: () {
              // Define action on topic click
              print('Tapped on ${topic.name}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopicDetailsPage(
                    imagePath: topic.imagePath,
                    topicName: topic.name,
                    topicDescription: topic.description,
                    pdfPath: topic.pdfPath,
                    videoUrl: topic.videoUrl,
                  ),
                ),
              );

            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  // Background image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      topic.imagePath,
                      width: 150, // Match width of the card
                      height: 150, // Match height of the container
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Title overlay
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                      child: Text(
                        topic.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1, // Limit to one line
                        overflow: TextOverflow.ellipsis, // Add ellipsis for overflow text
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
