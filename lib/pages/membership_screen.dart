import 'package:flutter/material.dart';
import 'package:shiksha/util/ColorSys.dart';

class MembershipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Membership Plans",
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

      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Choose Your Plan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorSys.primary,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildPlanCard(
                    context,
                    title: 'Free',
                    price: '\INR 0 / month',
                    features: [
                      'Access to basic courses',
                      'Limited study materials',
                      'Community support',
                    ],
                    color: Colors.green,
                    onTap: () {
                      // Action for Free plan
                      print('Selected Free Plan');
                    },
                  ),
                  SizedBox(height: 16),
                  _buildPlanCard(
                    context,
                    title: 'Premium',
                    price: 'INR 199 / month',
                    features: [
                      'All free plan features',
                      'Access to premium courses',
                      'Exclusive study materials',
                      'Priority support',
                    ],
                    color: Colors.blue,
                    onTap: () {
                      // Action for Premium plan
                      print('Selected Premium Plan');
                    },
                  ),
                  SizedBox(height: 16),
                  _buildPlanCard(
                    context,
                    title: 'Enterprise',
                    price: 'INR 500 / month',
                    features: [
                      'All premium plan features',
                      'Customized learning plans',
                      'Dedicated mentor support',
                      'Team collaboration tools',
                    ],
                    color: Colors.orange,
                    onTap: () {
                      // Action for Enterprise plan
                      print('Selected Enterprise Plan');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(
      BuildContext context, {
        required String title,
        required String price,
        required List<String> features,
        required Color color,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 12.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              SizedBox(height: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: features
                    .map(
                      (feature) => Row(
                    children: [
                      Icon(Icons.check, color: color, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                )
                    .toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Choose $title Plan',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
