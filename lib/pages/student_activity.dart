import 'package:flutter/material.dart';

class StudentActivityScreen extends StatelessWidget {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Student Activities",
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
        child: ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return ActivityCard(activity: activity);
          },
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
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
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

class StudentActivity {
  final String activityName;
  final String description;
  final String date;
  final String status;

  StudentActivity({
    required this.activityName,
    required this.description,
    required this.date,
    required this.status,
  });
}
