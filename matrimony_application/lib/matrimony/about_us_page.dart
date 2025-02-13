import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Typing Tutor',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add navigation logic here if needed
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.keyboard, size: 80, color: Colors.orange),
                  SizedBox(height: 8),
                  Text(
                    'Typing Tutor',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            _buildSectionHeader('Meet Our Team'),
            SizedBox(height: 8),
            _buildInfoRow('Developed by:', 'Mansi Fatepara (23010101079)'),
            _buildInfoRow(
                'Mentored by:',
                'Prof. Mehul Bhundiya (Computer Engineering Department), '
                    'School of Computer Science'),
            _buildInfoRow('Explored by:',
                'ASWDC, School Of Computer Science, School of Computer Science'),
            _buildInfoRow(
                'Eulogized by:', 'Darshan University, Rajkot, Gujarat - INDIA'),
            SizedBox(height: 24),
            _buildSectionHeader('About ASWDC'),
            SizedBox(height: 8),
            _buildUniversityInfo(),
            SizedBox(height: 24),
            _buildSectionHeader('Contact Us'),
            SizedBox(height: 8),
            _buildContactCard(),
            SizedBox(height: 24),
            _buildSectionHeader('Quick Links'),
            SizedBox(height: 8),
            _buildQuickLinks(),
            SizedBox(height: 24),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(content),
          ),
        ],
      ),
    );
  }

  Widget _buildUniversityInfo() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/img_2.png',
              height: 50,
            ),
            SizedBox(height: 16),
            Text(
              'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School of Computer Science.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8),
            Text(
              'The sole purpose of ASWDC is to bridge the gap between university curriculum and industry demands. Students learn cutting-edge technologies by working on real projects.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.email, color: Colors.purple),
                SizedBox(width: 8),
                Text('aswdc@darshan.ac.in'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.purple),
                SizedBox(width: 8),
                Text('+91-9727747317'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.language, color: Colors.purple),
                SizedBox(width: 8),
                Text('www.darshan.ac.in'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLinks() {
    return Column(
      children: [
        _buildQuickLinkRow(Icons.share, 'Share App'),
        _buildQuickLinkRow(Icons.apps, 'More Apps'),
        _buildQuickLinkRow(Icons.star, 'Rate Us'),
        _buildQuickLinkRow(Icons.thumb_up, 'Like us on Facebook'),
        _buildQuickLinkRow(Icons.update, 'Check For Update'),
      ],
    );
  }

  Widget _buildQuickLinkRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          Text(
            '© 2025 Darshan University',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            'All Rights Reserved - Privacy Policy',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 4),
          Text(
            'Made with ❤️ in India',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}