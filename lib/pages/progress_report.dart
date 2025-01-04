import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shiksha/pages/games_category_screen.dart';
import 'package:shiksha/pages/student_activity.dart';
import 'package:shiksha/util/ColorSys.dart';

import '../model/student_progress.dart';


class ProgressReportScreen extends StatelessWidget {
  final List<StudentProgress> progressData = [
    StudentProgress(subject: 'Math', grade: 85, teacherFeedback: 'Good progress, needs improvement in algebra'),
    StudentProgress(subject: 'Science', grade: 90, teacherFeedback: 'Excellent work in physics'),
    StudentProgress(subject: 'History', grade: 78, teacherFeedback: 'Keep up with the readings'),
    StudentProgress(subject: 'English', grade: 92, teacherFeedback: 'Great writing skills'),
    StudentProgress(subject: 'Art', grade: 88, teacherFeedback: 'Creative, needs to focus on technique'),
  ];

  final List<StudentActivity> activities = [
    StudentActivity(
      activityName: 'Completed Assignment',
      description: 'You completed the assignment on Algebra.',
      date: '2025-01-02',
      status: 'Completed',
    ),
    StudentActivity(
      activityName: 'Quiz on Physics',
      description: 'You scored 85% on the Physics quiz.',
      date: '2025-01-01',
      status: 'Reviewed',
    ),
    StudentActivity(
      activityName: 'Attended Webinar',
      description: 'Webinar on Quantum Physics with Dr. Smith.',
      date: '2024-12-30',
      status: 'Pending Review',
    ),
    StudentActivity(
      activityName: 'Group Discussion',
      description: 'Participated in a group discussion on Chemistry.',
      date: '2024-12-29',
      status: 'Completed',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Progress Report",
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
      body: SingleChildScrollView( // Wrap entire body with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            // Detailed Report section
            Text(
              'Detailed Report',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            // List of progress data
            ListView.builder(
              shrinkWrap: true,  // Allow ListView to shrink-wrap its content
              physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
              itemCount: progressData.length,
              itemBuilder: (context, index) {
                final studentProgress = progressData[index];
                return Card(
                  color: Colors.white,
                  elevation: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      studentProgress.subject,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(studentProgress.teacherFeedback),
                    trailing: Text(
                      '${studentProgress.grade}%',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 32),
            // Student Activities section
            Text(
              'Student Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            // List of student activities
            ListView.builder(
              shrinkWrap: true,  // Allow ListView to shrink-wrap its content
              physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return ActivityCard(activity: activity);
              },
            ),
          ],
        ),
      ),
    );
  }
}
class ActivityCard extends StatelessWidget {
  final StudentActivity activity;

  ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 12.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.activityName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Date: ${activity.date}',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              activity.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status: ${activity.status}',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(activity.status),
                  ),
                ),
                // IconButton(
                //   icon: Icon(Icons.arrow_forward_ios),
                //   onPressed: () {
                //     // Navigate to activity details screen if necessary
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Reviewed':
        return Colors.blue;
      case 'Pending Review':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class ProgressBarChart extends StatelessWidget {
  final List<StudentProgress> progressData;

  ProgressBarChart({required this.progressData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          barGroups: progressData.map((data) {
            return BarChartGroupData(
              x: progressData.indexOf(data),
              barRods: [
                BarChartRodData(
                  toY: data.grade,
                  width: 16,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
