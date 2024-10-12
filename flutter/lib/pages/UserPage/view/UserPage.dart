import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter1/controllers/User_controller.dart';
import 'package:flutter1/pages/UserPage/modules/ininfo.dart';
import 'package:flutter1/pages/UserPage/modules/product/index.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // Controller to manage the tab index
  late UserPageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = UserPageController(); // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
        backgroundColor: const Color.fromARGB(0, 253, 250, 250), // Make the AppBar background transparent
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFBD72B), // Start color (yellowish-orange)
                Color(0xFFF9484A), // End color (reddish-orange)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _controller.selectedIndex, // Show the selected tab content
        children: const [
          UserInfoTab(), // Display the user information tab
          ProductTab(),  // Display the product tab
        ],
      ),
      backgroundColor: Colors.white, // Set the background color to white for a clean look
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.orange, // Orange background for the bottom bar
        activeColor: Colors.white, // White color for the active tab
        color: Colors.white, // White color for inactive tabs (icon color)
        items: const [
          TabItem(icon: Icons.person, title: 'ข้อมูลผู้ใช้'), // User Info Tab
          TabItem(icon: Icons.shopping_cart, title: 'สินค้า'), // Product Tab
        ],
        initialActiveIndex: _controller.selectedIndex, // The initially selected tab
        onTap: (int i) {
          setState(() {
            _controller.updateIndex(i); // Update index through the controller
          });
        },
      ),
    );
  }
}
