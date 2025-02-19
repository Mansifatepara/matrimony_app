import 'package:flutter/material.dart';
import 'package:matrimony_application/matrimony/user_form_page.dart';
import 'package:matrimony_application/matrimony/utils_const_string.dart';

class UserDetailPage extends StatefulWidget {
  final Map<String, dynamic> user;

  UserDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.user['isLiked'] ?? false;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      widget.user['isLiked'] = isLiked;
    });
  }

  void _editUser() async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => userForm(),
      ),
    );

    if (updatedUser != null) {
      setState(() {
        widget.user.clear();
        widget.user.addAll(updatedUser);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 16),
            _buildDetailCard('Personal Details', [
              _buildDetailRow(Icons.email, 'Email: ${widget.user[EMAIL] ?? 'N/A'}'),
              _buildDetailRow(Icons.location_on, 'Address: ${widget.user[ADDRESS] ?? 'N/A'}'),
              _buildDetailRow(Icons.location_city, 'City: ${widget.user[CITY] ?? 'N/A'}'),
              _buildDetailRow(Icons.person, 'Gender: ${widget.user[GENDER] ?? 'N/A'}'),
            ]),
            _buildDetailCard('Hobbies', [
              _buildDetailRow(Icons.sports_esports,
                  'Hobbies: ${widget.user[HOBBIES] is List ? widget.user[HOBBIES].join(', ') : 'N/A'}'
              ),
            ]),
            _buildDetailCard('Contact Details', [
              _buildDetailRow(Icons.phone, 'Phone: ${widget.user[MOBILENUMBER] ?? 'N/A'}'),
            ]),
            _buildDetailCard('Security', [
              _buildDetailRow(Icons.lock, 'Password: ${widget.user[PASSWORD] ?? 'N/A'}'),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _editUser,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: widget.user['imageUrl'] != null
                  ? NetworkImage(widget.user['imageUrl'])
                  : null,
              backgroundColor: Colors.deepPurple.shade200,
              child: widget.user['imageUrl'] == null
                  ? const Icon(Icons.account_circle, size: 80, color: Colors.deepPurple)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              widget.user[FULLNAME] ?? 'No Name',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
