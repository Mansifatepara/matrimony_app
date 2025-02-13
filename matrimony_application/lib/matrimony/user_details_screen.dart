import 'package:flutter/material.dart';
import 'package:matrimony_application/matrimony/user_form_page.dart';

class UserDetailPage extends StatefulWidget {
  final Map<String, dynamic> user;
  final VoidCallback onDelete;
  final ValueChanged<Map<String, dynamic>> onEdit;

  const UserDetailPage({
    Key? key,
    required this.user,
    required this.onDelete,
    required this.onEdit,
    required bool isLiked,
    required void Function() onToggleLike,
  }) : super(key: key);

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
        widget.onEdit(updatedUser); // Update the user in the list
        widget.user.clear();
        widget.user.addAll(updatedUser); // Update local user state
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.pink,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Image and Name Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: widget.user['imageUrl'] != null
                              ? NetworkImage(widget.user['imageUrl'])
                              : null,
                          backgroundColor: Colors.pink.shade200,
                          child: widget.user['imageUrl'] == null
                              ? const Icon(
                            Icons.account_circle,
                            size: 80,
                            color: Colors.pink,
                          )
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.user['name'] ?? 'No Name',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Personal Details Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Personal Details',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink),
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.email,
                            'Email: ${widget.user['email'] ?? 'N/A'}'),
                        _buildDetailRow(Icons.location_on,
                            'Address: ${widget.user['address'] ?? 'N/A'}'),
                        _buildDetailRow(Icons.phone,
                            'Phone: ${widget.user['phone'] ?? 'N/A'}'),
                        _buildDetailRow(Icons.location_city,
                            'City: ${widget.user['city'] ?? 'N/A'}'),
                        _buildDetailRow(Icons.person,
                            'Gender: ${widget.user['gender'] ?? 'N/A'}'),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hobbies',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink),
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.sports_esports,
                            'Hobbies: ${widget.user['hobbies'] ?? 'N/A'}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _editUser,
        backgroundColor: Colors.pink,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.pink),
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